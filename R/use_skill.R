#' Install a skill into a project
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @keywords internal
.use_skill <- function(
  skill,
  data = list(),
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive(),
  call = caller_env()
) {
  save_as <- .path_skill_save_as(
    skill,
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    call = call
  )
  save_as_absolute <- .path_proj_save_as(save_as, overwrite, call = call)
  skill_path_relative <- fs::path("skills", skill, "SKILL.md")

  .use_template(
    skill_path_relative,
    save_as,
    data = data,
    open = open,
    call = call
  )
  .upsert_agents_skill_from_template(skill_path_relative, save_as, call = call)
  cli::cli_inform("Skill {.file {save_as}} installed.")
  invisible(save_as_absolute)
}

#' Build the project-relative save path for a skill file
#'
#' @inheritParams .shared-params
#' @returns (`character(1)`) Relative path to the `SKILL.md` file within the
#'   project.
#' @keywords internal
.path_skill_save_as <- function(
  skill,
  target_dir = ".github",
  use_skills_subdir = TRUE,
  call = caller_env()
) {
  skill <- stbl::to_character_scalar(skill, call = call)
  target_dir <- stbl::to_character_scalar(target_dir, call = call)
  use_skills_subdir <- stbl::to_lgl_scalar(use_skills_subdir, call = call)
  if (use_skills_subdir) {
    target_dir <- fs::path(target_dir, "skills")
  }
  fs::path(target_dir, skill, "SKILL.md")
}

#' Upsert a template skill row in the ## Skills table of AGENTS.md
#'
#' @param skill_path_relative (`character(1)`) The relative path to the
#'   `SKILL.md` file, relative to the template dir.
#' @inheritParams .shared-params
#' @inherit .upsert_agents_skill return
#' @keywords internal
.upsert_agents_skill_from_template <- function(
  skill_path_relative,
  save_as,
  call = caller_env()
) {
  template_path <- .path_template(skill_path_relative)
  trigger <- .read_skill_trigger(template_path, call = call)
  .upsert_agents_skill(trigger, save_as, call = call)
}

#' Read the trigger field from a skill template's YAML front matter
#'
#' @param path (`character(1)`) Path to the skill template file.
#' @inheritParams .shared-params
#' @returns (`character(1)`) The trigger phrase.
#' @keywords internal
.read_skill_trigger <- function(path, call = caller_env()) {
  path <- stbl::to_character_scalar(path, call = call)
  if (!fs::file_exists(path)) {
    .pkg_abort(
      "Template not found: {.file {path}}.",
      "template_not_found",
      call = call
    )
  }
  lines <- readLines(path, warn = FALSE)
  front_matter <- .parse_yaml_front_matter(lines, path, call = call)
  .extract_yaml_scalar(front_matter, "trigger", path, call = call)
}

#' Upsert a skill row in the ## Skills table of AGENTS.md
#'
#' @inheritParams .shared-params
#' @returns The path to `AGENTS.md`, invisibly, or `NULL` invisibly if
#'   `AGENTS.md` does not exist.
#' @keywords internal
.upsert_agents_skill <- function(trigger, save_as, call = caller_env()) {
  agents_path <- usethis::proj_path("AGENTS.md")
  if (!fs::file_exists(agents_path)) {
    return(invisible(NULL))
  }

  writeLines(
    .agents_lines_upsert_skill(agents_path, trigger, save_as, call = call),
    agents_path
  )
  invisible(agents_path)
}

#' Compute updated AGENTS.md lines with a skill row upserted
#'
#' Reads `path` and validates inputs. Replaces the existing row for `save_as`
#' if found; otherwise delegates to `.agents_lines_add_skill_row()`.
#'
#' @param path (`character(1)`) Path to `AGENTS.md`.
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_upsert_skill <- function(
  path,
  trigger,
  save_as,
  call = caller_env()
) {
  save_as <- stbl::to_character_scalar(save_as, call = call)
  lines <- readLines(path, warn = FALSE)
  new_row <- .make_skill_row(trigger, save_as, call = call)

  existing_idx <- .find_skill_row_idx(lines, save_as)
  if (length(existing_idx)) {
    return(.agents_lines_replace_row(lines, existing_idx, new_row))
  }
  .agents_lines_add_skill_row(lines, new_row)
}

#' Add a new skill row to AGENTS.md lines
#'
#' Appends a new `## Skills` section if none exists; otherwise delegates to
#' [.agents_lines_add_to_section()].
#'
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_add_skill_row <- function(lines, new_row) {
  section_idx <- .find_skills_section_idx(lines)
  if (!length(section_idx)) {
    return(.agents_lines_append_section(lines, new_row))
  }
  .agents_lines_add_to_section(lines, section_idx, new_row)
}

#' Add a skill row to an existing ## Skills section
#'
#' Inserts a new table if none exists in the section; otherwise appends the
#' row to the existing table.
#'
#' @param section_idx (`integer(1)`) Index of the `## Skills` heading line.
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_add_to_section <- function(lines, section_idx, new_row) {
  last_row_idx <- .find_table_last_row_idx(lines, section_idx)
  if (!length(last_row_idx)) {
    return(.agents_lines_insert_table(lines, section_idx, new_row))
  }
  .agents_lines_append_row(lines, last_row_idx, new_row)
}

#' Replace an existing skill row in AGENTS.md lines
#'
#' @param row_idx (`integer(1)`) Index of the row to replace.
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_replace_row <- function(lines, row_idx, new_row) {
  lines[[row_idx]] <- new_row
  lines
}

#' Append a new ## Skills section to AGENTS.md lines
#'
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_append_section <- function(lines, new_row) {
  c(lines, .make_skills_section(new_row))
}

#' Insert a skills table after the ## Skills heading in AGENTS.md lines
#'
#' @param section_idx (`integer(1)`) Index of the `## Skills` heading line.
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_insert_table <- function(lines, section_idx, new_row) {
  .lines_insert_after(lines, section_idx, .make_skills_table(new_row))
}

#' Append a skill row after the last table row in AGENTS.md lines
#'
#' @param last_row_idx (`integer(1)`) Index of the current last table row.
#' @inheritParams .shared-params
#' @returns (`character`) Updated lines.
#' @keywords internal
.agents_lines_append_row <- function(lines, last_row_idx, new_row) {
  .lines_insert_after(lines, last_row_idx, new_row)
}

#' Build a markdown table row for a skill
#'
#' @inheritParams .shared-params
#' @returns (`character(1)`) A markdown table row string.
#' @keywords internal
.make_skill_row <- function(trigger, save_as, call = caller_env()) {
  trigger <- stbl::to_character_scalar(trigger, call = call)
  paste0("| ", trigger, " | @", save_as, " |")
}

#' Build the header and data rows for a Skills markdown table
#'
#' @param row (`character(1)`) A pre-built skill row, e.g. from
#'   [.make_skill_row()].
#' @returns (`character`) Lines comprising the blank spacer, table header,
#'   separator, and data row.
#' @keywords internal
.make_skills_table <- function(row) {
  c("", "| Triggers | Path |", "|----------|------|", row)
}

#' Build a complete ## Skills section with a table
#'
#' @param row (`character(1)`) A pre-built skill row, e.g. from
#'   [.make_skill_row()].
#' @returns (`character`) Lines comprising the section heading and table.
#' @keywords internal
.make_skills_section <- function(row) {
  c("", "## Skills", .make_skills_table(row))
}

#' Find the line index of an existing skill row in AGENTS.md
#'
#' @inheritParams .shared-params
#' @returns (`integer(1)`) Index of the first matching line, or `integer()`.
#' @keywords internal
.find_skill_row_idx <- function(agents_lines, save_as) {
  .find_pattern_idx(agents_lines, stringr::fixed(paste0("@", save_as)))
}

#' Find the line index of the ## Skills section heading in AGENTS.md
#'
#' @inheritParams .shared-params
#' @returns (`integer(1)`) Index of the `## Skills` heading, or `integer()`.
#' @keywords internal
.find_skills_section_idx <- function(agents_lines) {
  .find_pattern_idx(agents_lines, "^## Skills")
}
