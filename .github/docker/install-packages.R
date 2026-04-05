pkgs <- c(
  "astgrepr",
  "callr",
  "cli",
  "covr",
  "desc",
  "devtools",
  "fs",
  "gh",
  "knitr",
  "magick",
  "pkgdown",
  "purrr",
  "rcmdcheck",
  "rlang",
  "rmarkdown",
  "roxygen2",
  "stbl",
  "stringr",
  "testthat",
  "usethis",
  "withr",
  "xml2"
)

# Try installing all packages at once. If that fails (e.g. a package needs a
# newer R or a missing system tool), fall back to one-by-one so the image still
# gets built with everything else.

tryCatch(
  pak::pak(pkgs),
  error = function(e) {
    warning(
      "Bulk install failed, retrying one-by-one: ",
      conditionMessage(e),
      call. = FALSE
    )
    for (pkg in pkgs) {
      tryCatch(
        pak::pak(pkg),
        error = function(e2) {
          warning("Skipping ", pkg, ": ", conditionMessage(e2), call. = FALSE)
        }
      )
    }
  }
)
