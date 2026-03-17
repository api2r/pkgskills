#' Call the GitHub API
#'
#' Thin wrapper around [gh::gh()] to facilitate mocking in tests.
#'
#' @param ... Arguments passed to [gh::gh()].
#' @returns The API response.
#' @keywords internal
.call_gh <- function(...) {
  # nocov start
  gh::gh(...)
  # nocov end
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
