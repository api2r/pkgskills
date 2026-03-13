#' Raise a package-scoped error
#'
#' @param message (`character(1)`) A `{cli}` message string.
#' @param subclass (`character(1)`) Error subclass.
#' @inheritParams .shared-params
#' @returns Does not return.
#' @keywords internal
.pkg_abort <- function(message, subclass, call = rlang::caller_env()) {
  stbl::pkg_abort(
    "pkgskills",
    message,
    subclass,
    call = call,
    message_env = rlang::caller_env()
  )
}
