#' Coerce to a non-null, non-empty character scalar
#'
#' @param x (`any`) The value to coerce.
#' @inheritParams .shared-params
#' @returns (`character(1)`) `x` coerced to a character scalar.
#' @keywords internal
.to_string <- function(x, x_arg = caller_arg(x), call = caller_env()) {
  stbl::to_character_scalar(
    x,
    allow_null = FALSE,
    allow_zero_length = FALSE,
    x_arg = x_arg,
    call = call
  )
}

#' Coerce to a non-null logical scalar
#'
#' @param x (`any`) The value to coerce.
#' @inheritParams .shared-params
#' @returns (`logical(1)`) `x` coerced to a logical scalar.
#' @keywords internal
.to_boolean <- function(x, x_arg = caller_arg(x), call = caller_env()) {
  stbl::to_lgl_scalar(x, allow_null = FALSE, x_arg = x_arg, call = call)
}

#' Build a path within the pkgskills package
#'
#' @param ... Path components, passed to [fs::path_package()].
#' @returns (`character(1)`) Absolute path within the pkgskills package.
#' @keywords internal
.path_pkg <- function(...) {
  fs::path_package("pkgskills", ...)
}

#' Build a path to a file in `inst/templates/`
#'
#' @param ... Path components appended after `"templates"`, passed to
#'   [.path_pkg()].
#' @returns (`character(1)`) Absolute path to the template file.
#' @keywords internal
.path_template <- function(...) {
  .path_pkg("templates", ...)
}

#' Check whether a file exists and act on it
#'
#' Deletes the file if it exists and `overwrite = TRUE`. Errors if the file
#' exists and `overwrite = FALSE`.
#'
#' @inheritParams .shared-params
#' @returns `NULL`, invisibly.
#' @keywords internal
.check_file_exists <- function(path, overwrite, call = rlang::caller_env()) {
  path <- .to_string(path, call = call)
  overwrite <- .to_boolean(overwrite, call = call)
  if (fs::file_exists(path)) {
    if (overwrite) {
      fs::file_delete(path)
    } else {
      .pkg_abort(
        "File {.file {path}} already exists.",
        "file_exists",
        call = call
      )
    }
  }
  invisible(NULL)
}
