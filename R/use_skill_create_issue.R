#' Install the create-issue skill into a project
#'
#' Fetches repository metadata from GitHub and renders the `create-issue` skill
#' template into the project. The installed skill teaches AI agents how to
#' create well-structured GitHub issues for the package.
#'
#' @param target_dir (`character(1)`) Directory where the skill will be
#'   installed, relative to the project root. Defaults to `".github"`.
#' @param use_skills_subdir (`logical(1)`) Whether to place the `create-issue`
#'   folder under a `skills` subdirectory of `target_dir`. Defaults to `TRUE`,
#'   producing `.github/skills/create-issue/SKILL.md`.
#' @param overwrite (`logical(1)`) Whether to overwrite an existing skill file.
#'   Defaults to `TRUE`.
#' @param gh_token (`character(1)`) A GitHub personal access token. Defaults to
#'   `gh::gh_token()`.
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_create_issue()
use_skill_create_issue <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token()
) {
  target_dir <- .to_string(target_dir)
  use_skills_subdir <- .to_boolean(use_skills_subdir)
  overwrite <- .to_boolean(overwrite)
  gh_token <- .to_string(gh_token)

  bug_reports <- desc::desc_get(
    "BugReports",
    file = usethis::proj_path("DESCRIPTION")
  )[[1L]]

  if (is.na(bug_reports)) {
    .pkg_abort(
      c(
        "No {.field BugReports} field found in {.file DESCRIPTION}.",
        "i" = "Run {.run usethis::use_github()} to set one up."
      ),
      "no_bug_reports"
    )
  }

  pattern <- "^https://github\\.com/([^/]+)/([^/]+)/issues"
  m <- regmatches(bug_reports, regexec(pattern, bug_reports))[[1L]]
  if (length(m) < 3L) {
    .pkg_abort(
      c(
        "{.field BugReports} in {.file DESCRIPTION} must be a GitHub issues URL.",
        "i" = "Run {.run usethis::use_github()} to set one up."
      ),
      "invalid_bug_reports"
    )
  }
  owner <- m[[2L]]
  repo <- m[[3L]]

  repo_result <- gh::gh(
    "POST /graphql",
    query = sprintf(
      '{ repository(owner: "%s", name: "%s") { id } }',
      owner,
      repo
    ),
    .token = gh_token
  )
  repo_id <- repo_result$data$repository$id

  types_result <- gh::gh(
    "POST /graphql",
    query = sprintf(
      paste0(
        '{ repository(owner: "%s", name: "%s") {',
        " issueTypes(first: 20) { nodes { id name description } } } }"
      ),
      owner,
      repo
    ),
    .token = gh_token
  )
  issue_types <- types_result$data$repository$issueTypes$nodes

  update_time <- format(
    Sys.time(),
    tz = "UTC",
    format = "%Y-%m-%d %H:%M:%S UTC"
  )

  data <- list(
    owner = owner,
    repo = repo,
    repo_id = repo_id,
    issue_types = issue_types,
    update_time = update_time
  )

  .use_skill(
    "create-issue",
    data = data,
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )
}
