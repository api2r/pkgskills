#' Install the create-issue skill into a project
#'
#' Fetches repository metadata from GitHub and renders the `create-issue` skill
#' template into the project. The installed skill teaches AI agents how to
#' create well-structured GitHub issues for the package.
#'
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
  data <- .get_create_issue_data(gh_token)
  .use_skill(
    "create-issue",
    data = data,
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )
}

#' Collect template data for the create-issue skill
#'
#' @inheritParams .shared-params
#' @returns (`list`) Named list of whisker template variables.
#' @keywords internal
.get_create_issue_data <- function(gh_token, call = caller_env()) {
  repo_parts <- .extract_repo_from_desc(call = call)
  owner <- repo_parts[["owner"]]
  repo <- repo_parts[["repo"]]
  update_time <- .format_now_utc()
  repo_id <- .fetch_repo_id(owner, repo, gh_token)
  issue_types <- .fetch_repo_issue_types(owner, repo, gh_token)
  list(
    owner = owner,
    repo = repo,
    repo_id = repo_id,
    issue_types = issue_types,
    update_time = update_time
  )
}

#' Extract owner and repo from DESCRIPTION BugReports field
#'
#' @inheritParams .shared-params
#' @returns (`list`) Named list with `owner` and `repo` elements.
#' @keywords internal
.extract_repo_from_desc <- function(call = caller_env()) {
  bug_reports <- desc::desc_get(
    "BugReports",
    file = usethis::proj_path("DESCRIPTION")
  )[[1L]]

  if (!length(bug_reports) || is.na(bug_reports)) {
    .pkg_abort(
      c(
        "No {.field BugReports} field found in {.file DESCRIPTION}.",
        "i" = "Run {.run usethis::use_github()} to set one up."
      ),
      "no_bug_reports",
      call = call
    )
  }

  pattern <- "^https://github\\.com/([^/]+)/([^/]+)/issues"
  url_pieces <- regmatches(bug_reports, regexec(pattern, bug_reports))[[1L]]
  if (length(url_pieces) < 3L) {
    .pkg_abort(
      c(
        "{.field BugReports} in {.file DESCRIPTION} must be a GitHub issues URL.",
        "i" = "Run {.run usethis::use_github()} to set one up."
      ),
      "invalid_bug_reports",
      call = call
    )
  }
  list(
    owner = url_pieces[[2L]],
    repo = url_pieces[[3L]]
  )
}

#' Fetch the GraphQL node ID for a GitHub repository
#'
#' @inheritParams .shared-params
#' @returns (`character(1)`) The repository's GraphQL node ID.
#' @keywords internal
.fetch_repo_id <- function(owner, repo, gh_token) {
  repo_result <- gh::gh(
    "POST /graphql",
    query = sprintf(
      '{ repository(owner: "%s", name: "%s") { id } }',
      owner,
      repo
    ),
    .token = gh_token
  )
  repo_result$data$repository$id
}

#' Fetch issue types defined for a GitHub repository
#'
#' @inheritParams .shared-params
#' @returns (`list`) Issue type nodes, each with `id`, `name`, and
#'   `description` fields.
#' @keywords internal
.fetch_repo_issue_types <- function(owner, repo, gh_token) {
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
  types_result$data$repository$issueTypes$nodes
}

#' Format the current time as a UTC timestamp string
#'
#' @returns (`character(1)`) Current time formatted as `"YYYY-MM-DD HH:MM:SS
#'   UTC"`.
#' @keywords internal
.format_now_utc <- function() {
  format(
    Sys.time(),
    tz = "UTC",
    format = "%Y-%m-%d %H:%M:%S UTC"
  )
}
