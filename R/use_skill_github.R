#' Install the github skill into a project
#'
#' Installs the `github` skill template into the project. The installed skill
#' teaches AI agents how to use the `gh` CLI and write conventional commit
#' messages for the package.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_github()
use_skill_github <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  .use_skill(
    "github",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )
}
