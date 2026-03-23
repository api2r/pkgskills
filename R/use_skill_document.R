#' Install the document skill into a project
#'
#' Installs the `document` skill template into the project and, if
#' `R/aaa-shared_params.R` does not already exist, creates a starter version
#' from a built-in template.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_document()
use_skill_document <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  skill_path <- .use_skill(
    "document",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )

  shared_params_path <- usethis::proj_path("R/aaa-shared_params.R")
  if (!fs::file_exists(shared_params_path)) {
    .use_template("aaa-shared_params.R", "R/aaa-shared_params.R")
    cli::cli_inform(c(
      "{.file R/aaa-shared_params.R} created.",
      "i" = paste(
        "Add shared parameters to it as your package grows.",
        "Functions can inherit shared parameters with {.code @inheritParams .shared-params}."
      )
    ))
  }

  invisible(skill_path)
}
