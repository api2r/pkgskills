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
