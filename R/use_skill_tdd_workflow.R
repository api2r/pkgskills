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
  invisible(.use_skill(
    "tdd-workflow",
    data = list(package = pkg_name),
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  ))
}
