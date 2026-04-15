#' Install GitHub Copilot code review instructions into a project
#'
#' Installs `copilot-instructions.md` into the project's `.github/` directory.
#' The default instructions tell Copilot code review to skip `.Rd` files in
#' `man/`.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed `.github/copilot-instructions.md`,
#'   invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_github_copilot_code_review()
use_github_copilot_code_review <- function(
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  overwrite <- stbl::to_lgl_scalar(overwrite)
  open <- stbl::to_lgl_scalar(open)

  path_instructions_abs <- .path_proj_save_as(
    ".github/copilot-instructions.md",
    overwrite
  )

  .use_template_as_is(
    "copilot-instructions.md",
    ".github/copilot-instructions.md",
    open = open
  )

  invisible(path_instructions_abs)
}
