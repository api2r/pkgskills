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
use_agent <- function(save_as = "AGENTS.md", open = rlang::is_interactive()) {
  save_as <- .to_string(save_as)
  data <- as.list(stats::na.omit(
    desc::desc_get(
      c("Package", "Title", "Description", "URL"),
      file = usethis::proj_path("DESCRIPTION")
    )
  ))
  .use_template("AGENTS.md", save_as, data, open)
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

#' Wrapper around [usethis::use_template()]
#'
#' @param template (`character(1)`) Template name within `inst/templates/`.
#' @inheritParams .shared-params
#' @returns Called for side effects.
#' @keywords internal
.use_template <- function(template, save_as, data, open, call = caller_env()) {
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
