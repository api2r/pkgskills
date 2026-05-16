#' Install the tdd-workflow skill into a project
#'
#' Installs the `tdd-workflow` skill into the project.
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
  usethis::use_package("stbl", min_version = "0.3.0.9000")
  usethis::use_testthat()
  .use_conditions_tests(overwrite, open)
  invisible(.use_skill(
    "tdd-workflow",
    data = list(package = pkg_name),
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  ))
}

#' Install the conditions tests template
#'
#' @inheritParams .shared-params
#' @returns The path to the installed test file, invisibly.
#' @keywords internal
.use_conditions_tests <- function(
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  usethis::use_package("stbl", min_version = "0.3.0.9000")
  conditions_path <- usethis::proj_path("tests/testthat/test-aaa-conditions.R")
  if (!fs::file_exists(conditions_path) || overwrite) {
    data <- .get_desc_fields("Package")
    .use_template(
      "test-aaa-conditions.R",
      "tests/testthat/test-aaa-conditions.R",
      data = data,
      open = open
    )
    .pkg_inform(
      "{.file tests/testthat/test-aaa-conditions.R} created or updated.",
      c("shared_file", "test_conditions")
    )
  }
  invisible(conditions_path)
}
