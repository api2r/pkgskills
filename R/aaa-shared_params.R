#' Shared parameters
#'
#' These parameters are used in multiple functions. They are defined here to
#' make them easier to import and to find.
#'
#' @param agents_lines (`character`) Lines of `AGENTS.md`.
#' @param allowlist (`character`) Hostnames to add to the GitHub Copilot coding
#'   agent firewall allowlist. Defaults to [default_allowlist()], a curated set
#'   of R and GitHub domains.
#' @param call (`environment`) The caller environment for error messages.
#' @param data (`list`) Named list of whisker template variables for rendering.
#' @param fields (`character`) Field name(s) to read from `DESCRIPTION`.
#' @param gh_token (`character(1)`) A GitHub personal access token. Defaults to
#'   `gh::gh_token()`.
#' @param lines (`character`) Lines of a file, as returned by [readLines()].
#' @param new_row (`character(1)`) A pre-built skill row string, as produced by
#'   `.make_skill_row()`.
#' @param open (`logical(1)`) Whether to open the file after creation.
#' @param overwrite (`logical(1)`) Whether to overwrite existing file(s).
#'   Defaults to `FALSE`.
#' @param owner (`character(1)`) GitHub repository owner (user or organization).
#' @param repo (`character(1)`) GitHub repository name.
#' @param save_as (`character(1)`) Output file path, relative to the project
#'   root.
#' @param skill (`character(1)`) Skill name. A folder name under
#'   `inst/templates/skills/`, e.g. `"create-issue"`. Determines the template
#'   path and the install subdirectory.
#' @param target_dir (`character(1)`) Directory where the skill will be
#'   installed, relative to the project root. Defaults to `".github"`.
#' @param trigger (`character(1)`) Trigger phrase for the skill.
#' @param use_skills_subdir (`logical(1)`) Whether to place the skill folder
#'   under a `skills` subdirectory of `target_dir`. Defaults to `TRUE`,
#'   producing `.github/skills/{skill}/SKILL.md`.
#' @param x_arg (`character(1)`) Argument name for `x`, used in error messages.
#'
#' @name .shared-params
#' @keywords internal
NULL
