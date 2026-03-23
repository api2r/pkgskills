#' Install the implement-issue skill into a project
#'
#' Installs the `implement-issue` skill template into the project. The
#' installed skill teaches AI agents how to implement GitHub issues end-to-end
#' in the package.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_implement_issue()
use_skill_implement_issue <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  skill_path <- .use_skill(
    "implement-issue",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )

  invisible(skill_path)
}
