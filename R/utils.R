#' Wrapper around [usethis::use_template()]
#'
#' @param template (`character(1)`) Template name within `inst/templates/`.
#' @inheritParams .shared-params
#' @returns Called for side effects.
#' @keywords internal
.use_template <- function(
  template,
  save_as,
  data = list(),
  open = FALSE,
  call = caller_env()
) {
  save_as <- .to_string(save_as, call = call)
  data <- stbl::to_list(data, call = call)
  template <- .to_string(template, call = call)
  open <- stbl::to_lgl_scalar(open, allow_null = FALSE, call = call)
  fs::dir_create(fs::path_dir(usethis::proj_path(save_as)))
  usethis::use_template(
    template,
    save_as = save_as,
    data = data,
    open = open,
    package = "pkgskills"
  )
}

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
