#' Install the search-code skill into a project
#'
#' Installs the `search-code` skill template into the project and, if
#' `astgrepr` is not already listed in `Imports` or `Suggests`, adds it to
#' `Suggests`.
#'
#' @inheritParams .shared-params
#' @returns The path to the installed skill file, invisibly.
#' @export
#' @examplesIf interactive()
#'
#'   use_skill_search_code()
use_skill_search_code <- function(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
) {
  deps <- desc::desc_get_deps(usethis::proj_path("DESCRIPTION"))
  if (!("astgrepr" %in% deps$package)) {
    usethis::use_package("astgrepr", "Suggests")
  }

  skill_path <- .use_skill(
    "search-code",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )

  invisible(skill_path)
}
