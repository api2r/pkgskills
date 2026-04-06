local_gh_mock <- function(
  issue_types = list(),
  repo_id = "R_testid",
  .local_envir = parent.frame()
) {
  local_mocked_bindings(
    .call_gh = function(...) {
      args <- list(...)
      if (isTRUE(grepl("issueTypes", args$query))) {
        list(
          data = list(repository = list(issueTypes = list(nodes = issue_types)))
        )
      } else if (!is.null(args$query)) {
        list(data = list(repository = list(id = repo_id)))
      } else {
        list()
      }
    },
    .env = .local_envir
  )
}

local_pkg <- function(
  ...,
  DESCRIPTION = c(
    "Package: mypkg",
    "Title: My Test Package",
    "Description: A package for testing.",
    "Version: 0.1.0",
    "URL: https://example.com",
    "BugReports: https://github.com/myorg/mypkg/issues"
  ),
  .local_envir = parent.frame()
) {
  extra <- list(...)
  if (length(extra) && !rlang::is_named(extra)) {
    cli::cli_abort(
      "All {.arg ...} arguments must have file paths as names.",
      call = .local_envir
    )
  }
  files <- c(list(DESCRIPTION = DESCRIPTION), extra)
  proj_dir <- withr::local_tempdir(.local_envir = .local_envir)
  for (name in names(files)) {
    out_path <- fs::path(proj_dir, name)
    fs::dir_create(fs::path_dir(out_path))
    writeLines(files[[name]], out_path)
  }
  usethis::local_project(proj_dir, quiet = TRUE, .local_envir = .local_envir)
  invisible(proj_dir)
}
