#' Build a path to a inst file within installed or dev pkgskills
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

#' Build and validate a project-relative output path
#'
#' @inheritParams .shared-params
#' @returns (`character(1)`) Absolute path to `save_as` within the active
#'   project.
#' @keywords internal
.path_proj_save_as <- function(save_as, overwrite, call = caller_env()) {
  path <- usethis::proj_path(save_as)
  .check_path_writable(path, overwrite, call = call)
  path
}

#' Check whether a path is writable
#'
#' @param path (`character(1)`) Absolute path to the file.
#' @inheritParams .shared-params
#' @returns `NULL`, invisibly. In part called for side effects: Deletes the file
#'   if it exists and `overwrite = TRUE`. Errors if the file exists and
#'   `overwrite = FALSE`.
#' @keywords internal
.check_path_writable <- function(path, overwrite, call = caller_env()) {
  path <- stbl::to_character_scalar(path, call = call)
  overwrite <- stbl::to_lgl_scalar(overwrite, call = call)
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
