#' Install the r-code skill into a project
#'
#' Installs the `r-code` skill template into the project and, if
#' `R/aaa-conditions.R` does not already exist, creates a starter version
#' from a built-in template.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_r_code()
use_skill_r_code <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  skill_path <- .use_skill(
    "r-code",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )

  conditions_path <- usethis::proj_path("R/aaa-conditions.R")
  if (!fs::file_exists(conditions_path)) {
    data <- .get_desc_fields("Package")
    .use_template("aaa-conditions.R", "R/aaa-conditions.R", data = data)
    usethis::use_package("stbl", min_version = "0.3.0")
    cli::cli_inform(c(
      "{.file R/aaa-conditions.R} created.",
      "i" = paste(
        "Use {.fn .pkg_abort} for package errors.",
        "Add more error helpers here as your package grows."
      )
    ))
  }

  invisible(skill_path)
}
