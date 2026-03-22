#' Install GitHub Copilot setup workflow into a project
#'
#' Installs a `copilot-setup-steps.yml` workflow and its companion reusable
#' `install` action into the project's `.github/workflows/` directory.
#'
#' @param overwrite (`logical(1)`) Whether to overwrite existing files.
#'   Defaults to `FALSE`.
#' @inheritParams .shared-params
#' @returns The path to the installed `.github/workflows/copilot-setup-steps.yml`,
#'   invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_github_copilot()
use_github_copilot <- function(
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  overwrite <- stbl::to_lgl_scalar(overwrite)
  open <- stbl::to_lgl_scalar(open)

  .path_proj_save_as(".github/workflows/copilot-setup-steps.yml", overwrite)
  .path_proj_save_as(".github/workflows/install/action.yml", overwrite)

  .use_template(
    "workflows/copilot-setup-steps.yml",
    ".github/workflows/copilot-setup-steps.yml",
    data = list(),
    open = open
  )
  .use_template(
    "workflows/install/action.yml",
    ".github/workflows/install/action.yml",
    data = list(),
    open = FALSE
  )

  invisible(usethis::proj_path(".github/workflows/copilot-setup-steps.yml"))
}
