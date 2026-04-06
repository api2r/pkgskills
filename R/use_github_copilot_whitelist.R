#' Update the GitHub Copilot coding agent firewall allowlist
#'
#' Adds the given hostnames to the Copilot coding agent firewall allowlist for
#' the current repository. If the GitHub token lacks the required permissions,
#' the user is informed of the settings URL and the list of hostnames so they
#' can add them manually. For details, see the
#' [Copilot firewall documentation](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/customize-the-agent-firewall#allowlisting-additional-hosts-in-the-agents-firewall).
#'
#' @inheritParams .shared-params
#' @returns `NULL`, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_github_copilot_whitelist()
use_github_copilot_whitelist <- function(
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
  repo_parts <- .extract_repo_from_desc()
  owner <- repo_parts[["owner"]]
  repo <- repo_parts[["repo"]]

  rlang::try_fetch(
    .set_copilot_allowlist(owner, repo, allowlist, gh_token),
    error = function(cnd) {
      cli::cli_warn(rlang::cnd_message(cnd))
      .inform_copilot_allowlist(owner, repo, allowlist)
    }
  )

  invisible(NULL)
}

#' Call the GitHub API to set the Copilot allowlist
#'
#' @inheritParams .shared-params
#' @returns The API response.
#' @keywords internal
.set_copilot_allowlist <- function(owner, repo, allowlist, gh_token) {
  # Expected endpoint once GitHub exposes it:
  # PUT /repos/{owner}/{repo}/copilot/coding-agent/firewall/allowlist
  .pkg_abort(
    "The allowlist cannot be updated through the api.",
    c("bad_endpoint", "allowlist")
  )
}

#' Inform the user of the Copilot allowlist URL and entries
#'
#' @inheritParams .shared-params
#' @returns `NULL`, invisibly.
#' @keywords internal
.inform_copilot_allowlist <- function(owner, repo, allowlist) {
  url <- glue::glue(
    "https://github.com/{owner}/{repo}/settings/copilot/coding_agent/allowlist"
  )
  cli::cli_inform(c(
    "Add the following hosts to the Copilot coding agent firewall allowlist at {.url {url}}:",
    allowlist
  ))
  invisible(NULL)
}
