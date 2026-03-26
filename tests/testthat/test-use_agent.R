test_that("use_agent() writes AGENTS.md and returns the path invisibly (#2)", {
  proj_dir <- local_pkg()
  result <- suppressMessages(use_agent(open = FALSE))
  expect_true(fs::file_exists(result))
  expect_equal(
    fs::path_real(result),
    fs::path_real(fs::path(proj_dir, "AGENTS.md"))
  )
})

test_that("use_agent() substitutes Package and Title into the template (#2, #59)", {
  proj_dir <- local_pkg()
  suppressMessages(use_agent(open = FALSE))
  expect_snapshot({
    writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
  })
})

test_that("use_agent() does not insert 'NA' when Description or URL is absent (#2, #59)", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: minpkg",
      "Title: Minimal Package",
      "Version: 0.1.0"
    )
  )
  suppressMessages(use_agent(open = FALSE))
  expect_snapshot({
    writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
  })
})

test_that("use_agent() emits an informational message after writing (#2)", {
  local_pkg()
  expect_snapshot({
    use_agent(open = FALSE)
  })
})

test_that("use_agent() errors on non-scalar save_as (#2)", {
  local_mocked_bindings(.use_template = function(...) {
    fail(".use_template should not be called.")
  })
  stbl::expect_pkg_error_classes(
    use_agent(save_as = c("AGENTS.md", "other.md")),
    "stbl",
    "non_scalar"
  )
})

test_that("use_agent() errors on NULL save_as (#2)", {
  local_mocked_bindings(.use_template = function(...) {
    fail(".use_template should not be called.")
  })
  stbl::expect_pkg_error_classes(
    use_agent(save_as = NULL),
    "stbl",
    "bad_null"
  )
})

test_that("use_agent() respects a custom save_as path (#2)", {
  proj_dir <- local_pkg()
  result <- suppressMessages(use_agent(
    save_as = "docs/AGENTS.md",
    open = FALSE
  ))
  expect_true(fs::file_exists(result))
  expect_equal(
    fs::path_real(result),
    fs::path_real(fs::path(proj_dir, "docs/AGENTS.md"))
  )
})

test_that("use_agent() errors if AGENTS.md exists and overwrite = FALSE (#36)", {
  proj_dir <- local_pkg("AGENTS.md" = "# existing")
  expect_error(
    suppressMessages(use_agent(open = FALSE)),
    class = "pkgskills-error-file_exists"
  )
  expect_equal(readLines(fs::path(proj_dir, "AGENTS.md")), "# existing")
})

test_that("use_agent() overwrites AGENTS.md when overwrite = TRUE (#36)", {
  proj_dir <- local_pkg("AGENTS.md" = "# existing")
  suppressMessages(use_agent(overwrite = TRUE, open = FALSE))
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("mypkg", content, fixed = TRUE)))
})
