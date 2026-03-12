#' Create an AGENTS.md file for your project
#'
#' @description
#' Writes a structured `AGENTS.md` file to help AI agents understand your
#' project. The repository overview is populated from your `DESCRIPTION` file;
#' everything else is generic boilerplate that your agent can then tailor.
#'
#' @param save_as (`character(1)`) File path (relative to the project root)
#'   where `AGENTS.md` will be written. Defaults to `"AGENTS.md"`.
#' @param open (`logical(1)`) Whether to open the file in the editor after
#'   creation. Defaults to `rlang::is_interactive()`.
#'
#' @return The path to the created file, invisibly.
#' @export
use_agent <- function(
  save_as = "AGENTS.md",
  open = rlang::is_interactive()
) {
  d <- desc::desc()
  # get_field() normalises multi-line values and returns NA for absent fields
  raw <- list(
    Package = d$get_field("Package", default = NA_character_),
    Title = d$get_field("Title", default = NA_character_),
    Description = d$get_field("Description", default = NA_character_),
    URL = d$get_field("URL", default = NA_character_)
  )

  # Replace NA with NULL so whisker sections are skipped for missing fields
  data <- lapply(raw, function(x) if (is.na(x)) NULL else x)

  .use_template(save_as, data, open)

  path <- .proj_path(save_as)

  cli::cli_inform(c(
    "{.file AGENTS.md} created.",
    "i" = paste0(
      "To tailor it to your project, tell your AI agent this: ",
      "\"Tailor @AGENTS.md to reflect this repository's actual structure. ",
      "Focus on the **Repository overview** and the **Key files** table.\""
    )
  ))

  invisible(path)
}

.use_template <- function(save_as, data, open) {
  usethis::use_template(
    "AGENTS.md",
    save_as = save_as,
    data = data,
    open = open,
    package = "pkgskills"
  )
}

.proj_path <- function(save_as) {
  usethis::proj_path(save_as)
}
