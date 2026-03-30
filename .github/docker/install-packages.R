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
  "wranglezone/stbl",
  "stringr",
  "testthat",
  "usethis",
  "withr",
  "xml2"
)

# --- Layer 1: pre-filter by dependency resolution --------------------------
# Use pak to resolve each package individually. This correctly checks R version
# requirements across all sources (CRAN source, PPM binaries, GitHub, etc.),
# unlike available.packages() which only queries the configured repo index
# (PPM binaries in rocker images, which may not list packages needing Rust, etc.).

installable <- character()
for (pkg in pkgs) {
  tryCatch({
    pak::pkg_deps(pkg)
    installable <- c(installable, pkg)
  }, error = function(e) {
    warning("Skipping ", pkg, " (not available for R ", getRversion(), ")", call. = FALSE)
  })
}

# --- Layer 2: install with build-failure fallback --------------------------

tryCatch(
  pak::pak(installable),
  error = function(e) {
    warning("Bulk install failed, retrying one-by-one: ", conditionMessage(e), call. = FALSE)
    for (pkg in installable) {
      tryCatch(
        pak::pak(pkg),
        error = function(e2) {
          warning("Skipping ", pkg, ": ", conditionMessage(e2), call. = FALSE)
        }
      )
    }
  }
)
