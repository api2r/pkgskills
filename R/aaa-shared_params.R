#' Shared parameters
#'
#' These parameters are used in multiple functions. They are defined here to
#' make them easier to import and to find.
#'
#' @param call (`environment`) The caller environment for error messages.
#' @param data (`list`) Named list of whisker template variables for rendering.
#' @param open (`logical(1)`) Whether to open the file after creation.
#' @param overwrite (`logical(1)`) Whether to overwrite an existing skill file.
#'   Defaults to `TRUE`.
#' @param save_as (`character(1)`) Output file path, relative to project root.
#' @param target_dir (`character(1)`) Directory where the skill will be
#'   installed, relative to the project root. Defaults to `".github"`.
#' @param use_skills_subdir (`logical(1)`) Whether to place the skill folder
#'   under a `skills` subdirectory of `target_dir`. Defaults to `TRUE`,
#'   producing `.github/skills/{skill}/SKILL.md`.
#' @param x_arg (`character(1)`) Argument name for `x`, used in error messages.
#'
#' @name .shared-params
#' @keywords internal
NULL
