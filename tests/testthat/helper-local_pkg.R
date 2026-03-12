local_pkg <- function(
  ...,
  DESCRIPTION = c(
    "Package: mypkg",
    "Title: My Test Package",
    "Description: A package for testing.",
    "Version: 0.1.0",
    "URL: https://example.com"
  ),
  .local_envir = parent.frame()
) {
  extra <- list(...)
  if (length(extra) && !rlang::is_named(extra)) {
    cli::cli_abort(
      "All {.arg ...} arguments must have file paths as names.",
      call = .local_envir
    )
  }
  files <- c(list(DESCRIPTION = DESCRIPTION), extra)
  proj_dir <- withr::local_tempdir(.local_envir = .local_envir)
  for (name in names(files)) {
    out_path <- fs::path(proj_dir, name)
    fs::dir_create(fs::path_dir(out_path))
    writeLines(files[[name]], out_path)
  }
  usethis::local_project(proj_dir, quiet = TRUE, .local_envir = .local_envir)
  invisible(proj_dir)
}
