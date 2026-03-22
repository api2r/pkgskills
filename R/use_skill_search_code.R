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
  overwrite = TRUE,
  open = rlang::is_interactive()
) {
  skill_path <- .use_skill(
    "search-code",
    target_dir = target_dir,
    use_skills_subdir = use_skills_subdir,
    overwrite = overwrite,
    open = open
  )

  desc_path <- usethis::proj_path("DESCRIPTION")
  d <- desc::desc(desc_path)
  deps <- d$get_deps()
  already_dep <- "astgrepr" %in%
    deps[deps$type %in% c("Imports", "Suggests"), "package"]
  if (!already_dep) {
    d$set_dep("astgrepr", "Suggests")
    d$write()
    cli::cli_inform(
      c(v = "Adding {.pkg astgrepr} to {.field Suggests} field in DESCRIPTION.")
    )
  }

  invisible(skill_path)
}
