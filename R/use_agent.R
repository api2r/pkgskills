#' Create an AGENTS.md file for your project
#'
#' Writes a structured `AGENTS.md` file to help AI agents understand your
#' project. The repository overview is populated from your `DESCRIPTION` file.
#'
#' @inheritParams .shared-params
#' @returns The path to the created file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_agent()
use_agent <- function(
  save_as = "AGENTS.md",
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  save_as <- stbl::to_character_scalar(save_as)
  overwrite <- stbl::to_lgl_scalar(overwrite)
  .path_proj_save_as(save_as, overwrite)
  data <- .get_desc_fields(c("Package", "Title", "Description", "URL"))
  .use_template("AGENTS.md", save_as, data = data, open = open)
  cli::cli_inform(c(
    "{.file AGENTS.md} created.",
    "i" = paste0(
      "To tailor it to your project, tell your AI agent this: ",
      "\"Tailor @AGENTS.md to reflect this repository's actual structure. ",
      "Focus on the **Repository overview** and the **Key files** table.\""
    )
  ))
  invisible(usethis::proj_path(save_as))
}
