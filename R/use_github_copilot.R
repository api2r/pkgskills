#' Install GitHub Copilot setup workflow into a project
#'
#' Installs a `copilot-setup-steps.yml` workflow into the project's
#' `.github/workflows/` directory. Also calls [use_github_copilot_whitelist()]
#' to configure the coding agent firewall allowlist.
#'
#' @param overwrite (`logical(1)`) Whether to overwrite existing files. Defaults
#'   to `FALSE`.
#' @inheritParams .shared-params
#' @returns The path to the installed
#'   `.github/workflows/copilot-setup-steps.yml`, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_github_copilot()
use_github_copilot <- function(
  overwrite = FALSE,
  open = rlang::is_interactive(),
  allowlist = c(
    "api.github.com",
    "api2r.org",
    "bioconductor.org",
    "cloud.r-project.org",
    "CRAN.R-project.org",
    "docs.github.com",
    "r-lib.org",
    "rstudio.github.io",
    "tidymodels.org",
    "tidyverse.org",
    "wrangle.zone"
  ),
  gh_token = gh::gh_token()
) {
  overwrite <- stbl::to_lgl_scalar(overwrite)
  open <- stbl::to_lgl_scalar(open)

  path_copilot_abs <- .path_proj_save_as(
    ".github/workflows/copilot-setup-steps.yml",
    overwrite
  )

  .use_template_as_is(
    "workflows/copilot-setup-steps.yml",
    ".github/workflows/copilot-setup-steps.yml",
    open = open
  )

  use_github_copilot_whitelist(allowlist = allowlist, gh_token = gh_token)

  invisible(path_copilot_abs)
}
