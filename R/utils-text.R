#' Find the index of the first line matching a pattern
#'
#' @inheritParams .shared-params
#' @param pattern (`character(1)`) A regex pattern or [stringr::fixed()] string
#'   to match against each line.
#' @returns (`integer(1)`) Index of the first matching line, or `integer(0)` if
#'   no line matches.
#' @keywords internal
.find_pattern_idx <- function(lines, pattern) {
  utils::head(stringr::str_which(lines, pattern), 1L)
}

#' Identify elements belonging to the first contiguous run
#'
#' @param x (`integer`) A sorted integer vector.
#' @returns (`logical`) `TRUE` for each element that belongs to the first
#'   unbroken run (no gap of more than 1 between consecutive values), `FALSE`
#'   once a gap is encountered.
#' @keywords internal
.is_first_run <- function(x) {
  !cumsum(c(FALSE, diff(x) > 1L))
}

#' Find the index of the last markdown table row after a given position
#'
#' Returns the last index of the first contiguous block of `|`-starting lines
#' found after `from`.
#'
#' @inheritParams .shared-params
#' @param from (`integer(1)`) Starting position; only lines after `from` are
#'   considered.
#' @returns (`integer(1)`) Index of the last table row, or `integer(0)` if
#'   none was found.
#' @keywords internal
.find_table_last_row_idx <- function(lines, from) {
  idx <- which(stringr::str_starts(lines, stringr::fixed("|")))
  idx <- idx[idx > from]
  if (!length(idx)) {
    return(integer(0))
  }
  utils::tail(idx[.is_first_run(idx)], 1L)
}

#' Extract YAML front matter lines from a character vector
#'
#' @param path (`character(1)`) File path, used only in error messages.
#' @inheritParams .shared-params
#' @returns (`character`) Lines between the opening and closing `---`
#'   delimiters.
#' @keywords internal
.parse_yaml_front_matter <- function(lines, path, call = caller_env()) {
  delim_idx <- which(lines == "---")
  if (length(delim_idx) < 2L) {
    .pkg_abort(
      "No YAML front matter found in {.file {path}}.",
      "no_front_matter",
      call = call
    )
  }
  lines[(delim_idx[[1L]] + 1L):(delim_idx[[2L]] - 1L)]
}

#' Extract a scalar value from YAML front matter lines
#'
#' @param front_matter (`character`) Lines of YAML front matter.
#' @param field (`character(1)`) Field name to extract.
#' @param path (`character(1)`) File path, used only in error messages.
#' @inheritParams .shared-params
#' @returns (`character(1)`) The trimmed value for `field`.
#' @keywords internal
.extract_yaml_scalar <- function(
  front_matter,
  field,
  path,
  call = caller_env()
) {
  pattern <- stringr::regex(paste0("^", field, ":"))
  match <- stringr::str_subset(front_matter, pattern)
  if (!length(match)) {
    .pkg_abort(
      "No {.field {field}} field in front matter of {.file {path}}.",
      paste0("no_", field),
      call = call
    )
  }
  stringr::str_remove(match[[1L]], pattern) |> trimws()
}

#' Insert lines into a character vector after a given index
#'
#' @inheritParams .shared-params
#' @param idx (`integer(1)`) Position after which `new_lines` will be inserted.
#' @param new_lines (`character`) Lines to insert.
#' @returns (`character`) Updated lines with `new_lines` spliced in after `idx`.
#' @keywords internal
.lines_insert_after <- function(lines, idx, new_lines) {
  tail <- if (idx < length(lines)) {
    lines[seq(idx + 1L, length(lines))]
  } else {
    character(0L)
  }
  c(lines[seq_len(idx)], new_lines, tail)
}
