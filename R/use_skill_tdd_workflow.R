#' Install the tdd-workflow skill into a project
#'
#' Installs the `tdd-workflow` skill into the project and, if
#' `tests/testthat/helper-expectations.R` does not already exist, creates it
#' from the package template.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_tdd_workflow()
use_skill_tdd_workflow <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  pkg_name <- .get_desc_fields("Package")[["Package"]]
  if (!length(pkg_name)) {
    .pkg_abort(
      "No {.field Package} field found in {.file DESCRIPTION}.",
      "no_package_field"
    )
  }
  skill_path <- .use_skill(
    "tdd-workflow",
    data = list(package = pkg_name),
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )
  helper_path <- "tests/testthat/helper-expectations.R"
  if (!fs::file_exists(usethis::proj_path(helper_path))) {
    .use_template(
      "helper-expectations.R",
      helper_path,
      list(package = pkg_name),
      open = FALSE
    )
    cli::cli_inform(c(
      "{.file {helper_path}} created.",
      "i" = paste0(
        "Inspect the helper and add any project-specific ",
        "{.fn transform} functions as needed."
      )
    ))
  }
  invisible(skill_path)
}
