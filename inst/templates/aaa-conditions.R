#' Signal a package-scoped error
#'
#' @inheritParams .shared-params
#' @inheritParams stbl::pkg_abort
#' @returns Does not return.
#' @keywords internal
.pkg_abort <- function(
  message,
  subclass,
  parent = NULL,
  call = caller_env(),
  message_env = caller_env(),
  ...
) {
  stbl::pkg_abort(
    "{{{Package}}}",
    message,
    subclass,
    call = call,
    message_env = message_env,
    parent = parent,
    ...
  )
}

#' Signal a package-scoped warning
#'
#' @inheritParams .shared-params
#' @inheritParams stbl::pkg_warn
#' @returns Does not return.
#' @keywords internal
.pkg_warn <- function(
  message,
  subclass,
  parent = NULL,
  call = caller_env(),
  message_env = caller_env(),
  ...
) {
  stbl::pkg_warn(
    "{{{Package}}}",
    message,
    subclass,
    call = call,
    message_env = message_env,
    parent = parent,
    ...
  )
}

#' Signal a package-scoped message
#'
#' @inheritParams .shared-params
#' @inheritParams stbl::pkg_inform
#' @returns Does not return.
#' @keywords internal
.pkg_inform <- function(
  message,
  subclass,
  parent = NULL,
  call = caller_env(),
  message_env = caller_env(),
  ...
) {
  stbl::pkg_inform(
    "{{{Package}}}",
    message,
    subclass,
    call = call,
    message_env = message_env,
    parent = parent,
    ...
  )
}
