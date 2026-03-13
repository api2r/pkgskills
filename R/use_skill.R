#' Install a skill into a project
#'
#' Internal helper that renders and writes a skill template, and upserts the
#' `## Skills` table in `AGENTS.md` when it exists.
#'
#' @param skill (`character(1)`) Skill name — folder name under
#'   `inst/templates/skills/`, e.g. `"create-issue"`. Determines the template
#'   path and the install subdirectory.
#' @param data (`list`) Named list of whisker template variables.
#' @param target_dir (`character(1)`) Directory where the skill will be
#'   installed, relative to the project root. Defaults to `".github"`.
#' @param use_skills_subdir (`logical(1)`) Whether to place the skill folder
#'   under a `skills` subdirectory of `target_dir`. Defaults to `TRUE`,
#'   producing `.github/skills/{skill}/SKILL.md`.
#' @param overwrite (`logical(1)`) Whether to overwrite an existing skill file.
#'   Defaults to `TRUE`.
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @keywords internal
.use_skill <- function(
  skill,
  data,
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive()
) {
  skill <- .to_string(skill)
  data <- stbl::to_list(data)
  target_dir <- .to_string(target_dir)
  use_skills_subdir <- stbl::to_lgl_scalar(
    use_skills_subdir,
    allow_null = FALSE
  )
  overwrite <- stbl::to_lgl_scalar(overwrite, allow_null = FALSE)

  if (use_skills_subdir) {
    save_as <- fs::path(target_dir, "skills", skill, "SKILL.md")
  } else {
    save_as <- fs::path(target_dir, skill, "SKILL.md")
  }

  template_path <- system.file(
    "templates",
    "skills",
    skill,
    "SKILL.md",
    package = "pkgskills"
  )
  trigger <- .read_skill_trigger(template_path)

  path <- usethis::proj_path(save_as)
  if (overwrite && fs::file_exists(path)) {
    fs::file_delete(path)
  } else if (!overwrite && fs::file_exists(path)) {
    cli::cli_inform("Skill {.file {save_as}} already exists. Skipping.")
    return(invisible(path))
  }

  fs::dir_create(fs::path_dir(path))
  .use_template(paste0("skills/", skill, "/SKILL.md"), save_as, data, open)

  agents_path <- usethis::proj_path("AGENTS.md")
  if (fs::file_exists(agents_path)) {
    .upsert_agents_skills_row(agents_path, trigger, save_as)
  }

  cli::cli_inform("Skill {.file {save_as}} installed.")
  invisible(path)
}

#' Read the trigger field from a skill template's YAML front matter
#'
#' @param path (`character(1)`) Path to the skill template file.
#' @inheritParams .shared-params
#' @returns (`character(1)`) The trigger phrase.
#' @keywords internal
.read_skill_trigger <- function(path, call = rlang::caller_env()) {
  path <- .to_string(path, call = call)
  if (!fs::file_exists(path)) {
    .pkg_abort(
      "Template not found: {.file {path}}.",
      "template_not_found",
      call = call
    )
  }
  lines <- readLines(path, warn = FALSE)
  delim_idx <- which(lines == "---")
  if (length(delim_idx) < 2L) {
    .pkg_abort(
      "No YAML front matter found in {.file {path}}.",
      "no_front_matter",
      call = call
    )
  }
  front_matter <- lines[(delim_idx[[1L]] + 1L):(delim_idx[[2L]] - 1L)]
  trigger_line <- grep("^trigger:", front_matter, value = TRUE)
  if (length(trigger_line) == 0L) {
    .pkg_abort(
      "No {.field trigger} field in front matter of {.file {path}}.",
      "no_trigger",
      call = call
    )
  }
  trimws(sub("^trigger:", "", trigger_line[[1L]]))
}

#' Upsert a skill row in the ## Skills table of AGENTS.md
#'
#' @param agents_path (`character(1)`) Path to the `AGENTS.md` file.
#' @param trigger (`character(1)`) Trigger phrase for the skill.
#' @param save_as (`character(1)`) Relative path to the installed skill file.
#' @returns The path to `AGENTS.md`, invisibly.
#' @keywords internal
.upsert_agents_skills_row <- function(agents_path, trigger, save_as) {
  agents_path <- .to_string(agents_path)
  trigger <- .to_string(trigger)
  save_as <- .to_string(save_as)

  lines <- readLines(agents_path, warn = FALSE)
  save_as_escaped <- gsub("([.|*+?^${}()\\[\\]\\\\])", "\\\\\\1", save_as)
  existing_idx <- grep(paste0("@", save_as_escaped), lines)

  if (length(existing_idx) > 0L) {
    lines[[existing_idx[[1L]]]] <- paste0("| ", trigger, " | @", save_as, " |")
    writeLines(lines, agents_path)
    return(invisible(agents_path))
  }

  skills_idx <- grep("^## Skills", lines)

  if (length(skills_idx) == 0L) {
    new_section <- c(
      "",
      "## Skills",
      "",
      "| Triggers | Path |",
      "|----------|------|",
      paste0("| ", trigger, " | @", save_as, " |")
    )
    writeLines(c(lines, new_section), agents_path)
    return(invisible(agents_path))
  }

  # Find the last table row in the ## Skills section
  section_start <- skills_idx[[1L]]
  last_table_row <- NA_integer_
  for (i in seq(section_start + 1L, length(lines))) {
    if (grepl("^\\|", lines[[i]])) {
      last_table_row <- i
    } else if (!is.na(last_table_row)) {
      break
    }
  }

  new_row <- paste0("| ", trigger, " | @", save_as, " |")
  if (is.na(last_table_row)) {
    insert_idx <- section_start
    lines <- c(
      lines[seq_len(insert_idx)],
      "",
      "| Triggers | Path |",
      "|----------|------|",
      new_row,
      lines[seq(insert_idx + 1L, length(lines))]
    )
  } else {
    tail_lines <- if (last_table_row < length(lines)) {
      lines[seq(last_table_row + 1L, length(lines))]
    } else {
      character(0L)
    }
    lines <- c(lines[seq_len(last_table_row)], new_row, tail_lines)
  }

  writeLines(lines, agents_path)
  invisible(agents_path)
}
