#' Update the full AI agent suite for a project
#'
#' Thin wrapper around [use_ai()] with `overwrite = TRUE` by default.
#'
#' @inheritParams use_ai
#' @returns A named list of paths returned by [use_ai()], invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   update_ai()
update_ai <- function(
  save_agent_as = "AGENTS.md",
  target_skills_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token(),
  allowlist = default_allowlist(),
  skills = c(
    "create-issue",
    "document",
    "github",
    "implement-issue",
    "r-code",
    "search-code",
    "tdd-workflow"
  )
) {
  use_ai(
    save_agent_as = save_agent_as,
    target_skills_dir = target_skills_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open,
    gh_token = gh_token,
    allowlist = allowlist,
    skills = skills
  )
}
