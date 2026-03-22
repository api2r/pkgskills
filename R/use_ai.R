#' Set up the full AI agent suite for a project
#'
#' Calls [use_agent()] and [use_github_copilot()] unconditionally, then
#' installs each skill in `skills`. Returns a named list of all paths
#' invisibly.
#'
#' @param save_agent_as (`character(1)`) Output path for `AGENTS.md`, relative
#'   to the project root. Passed to [use_agent()] as `save_as`.
#' @param target_skills_dir (`character(1)`) Directory where skills will be
#'   installed. Passed to all `use_skill_*()` functions as `target_dir`.
#' @param skills (`character`) Which skills to install. Defaults to all known
#'   skills. Validated with `rlang::arg_match(skills, multiple = TRUE)`. Pass
#'   a subset to install only specific skills, or `character(0)` for none.
#' @inheritParams .shared-params
#' @returns A named list of paths returned by each wrapped function, invisibly.
#'   Names match the function name that produced each path (e.g.
#'   `list(use_agent = ..., use_github_copilot = ...,
#'   use_skill_create_issue = ..., ...)`). Skills not selected are omitted.
#' @export
#' @examplesIf interactive()
#'
#'   use_ai()
use_ai <- function(
  save_agent_as = "AGENTS.md",
  target_skills_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token(),
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
  skills <- rlang::arg_match(skills, multiple = TRUE)

  agent_path <- use_agent(save_as = save_agent_as, open = open)
  copilot_path <- use_github_copilot(overwrite = overwrite, open = open)

  skill_fn_names <- stringr::str_c(
    "use_skill_",
    stringr::str_replace_all(skills, "-", "_")
  )
  skill_paths <- purrr::map2(skills, skill_fn_names, function(skill, fn_name) {
    fn <- match.fun(fn_name)
    extra_args <- if (skill == "create-issue") {
      list(gh_token = gh_token)
    } else {
      list()
    }
    rlang::exec(
      fn,
      target_dir = target_skills_dir,
      use_skills_subdir = use_skills_subdir,
      overwrite = overwrite,
      open = open,
      !!!extra_args
    )
  })
  names(skill_paths) <- skill_fn_names

  invisible(c(
    list(use_agent = agent_path, use_github_copilot = copilot_path),
    skill_paths
  ))
}
