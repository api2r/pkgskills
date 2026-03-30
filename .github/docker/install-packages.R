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

# --- Layer 1: pre-filter by metadata compatibility -------------------------

is_remote <- grepl("/", pkgs)
cran_refs  <- pkgs[!is_remote]
other_refs <- pkgs[is_remote]

# available.packages() only lists packages compatible with this R version
avail     <- rownames(available.packages())
cran_ok   <- cran_refs[cran_refs %in% avail]
pre_skip  <- setdiff(cran_refs, cran_ok)

# For remote refs, resolve individually to check R version compatibility
other_ok <- character()
for (ref in other_refs) {
  tryCatch({
    pak::pkg_deps(ref)
    other_ok <- c(other_ok, ref)
  }, error = function(e) {
    pre_skip <<- c(pre_skip, ref)
  })
}

if (length(pre_skip)) {
  message(
    "Skipping (incompatible with R ", getRversion(), "): ",
    paste(pre_skip, collapse = ", ")
  )
}

# --- Layer 2: install with build-failure fallback --------------------------

installable <- c(cran_ok, other_ok)

tryCatch(
  pak::pak(installable),
  error = function(e) {
    message("Bulk install failed, retrying one-by-one...\n", conditionMessage(e))
    for (pkg in installable) {
      tryCatch(
        pak::pak(pkg),
        error = function(e2) {
          message("Skipping ", pkg, ": ", conditionMessage(e2))
        }
      )
    }
  }
)
