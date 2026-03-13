#' Install a skill into a project
#'
#' @param skill (`character(1)`) Skill name. A folder name under
#'   `inst/templates/skills/`, e.g. `"create-issue"`. Determines the template
#'   path and the install subdirectory.
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @keywords internal
.use_skill <- function(
  skill,
  data,
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  call = caller_env()
) {
  # Validate inputs.
  skill <- .to_string(skill, call = call)
  target_dir <- .to_string(target_dir, call = call)
  use_skills_subdir <- .to_boolean(use_skills_subdir, call = call)

  # Set up path vars.
  if (use_skills_subdir) {
    target_dir <- fs::path(target_dir, "skills")
  }
  save_as <- fs::path(target_dir, skill, "SKILL.md")
  path <- usethis::proj_path(save_as)
  .check_file_exists(path, overwrite, call = call)
  skill_subpath <- fs::path("skills", skill, "SKILL.md")

  .use_template(skill_subpath, save_as, data, open, call = call)
  .upsert_agents_skill_from_template(skill_subpath, save_as, call = call)
  cli::cli_inform("Skill {.file {save_as}} installed.")
  invisible(path)
}

#' Upsert a template skill row in the ## Skills table of AGENTS.md
#'
#' @param skill_subpath (`character(1)`) The relative path to the `SKILL.md`
#'   file.
#' @inheritParams .shared-params
#' @inherit .upsert_agents_skill return
#' @keywords internal
.upsert_agents_skill_from_template <- function(
  skill_subpath,
  save_as,
  call = caller_env()
) {
  template_path <- .path_template(skill_subpath)
  trigger <- .read_skill_trigger(template_path, call = call)
  .upsert_agents_skill(trigger, save_as)
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
  if (!length(trigger_line)) {
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
#' @param trigger (`character(1)`) Trigger phrase for the skill.
#' @param save_as (`character(1)`) Relative path to the installed skill file.
#' @returns The path to `AGENTS.md`, invisibly, or `NULL` invisibly if
#'   `AGENTS.md` does not exist.
#' @keywords internal
.upsert_agents_skill <- function(trigger, save_as, call = caller_env) {
  # TODO: Clean this code and make sure it's stable. Consider using a dedicated
  # MD package.
  trigger <- .to_string(trigger, call = call)
  save_as <- .to_string(save_as, call = call)

  agents_path <- usethis::proj_path("AGENTS.md")
  if (!fs::file_exists(agents_path)) {
    return(invisible(NULL))
  }

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
