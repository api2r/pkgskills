test_that("use_agent() writes AGENTS.md and returns the path invisibly (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Description: A package for testing.",
      "Version: 0.1.0",
      "URL: https://example.com"
    ),
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
  result <- suppressMessages(use_agent(open = FALSE))
  expect_true(fs::file_exists(result))
  expect_equal(
    fs::path_real(result),
    fs::path_real(fs::path(proj_dir, "AGENTS.md"))
  )
})

test_that("use_agent() substitutes Package and Title into the template (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: coolpkg",
      "Title: A Cool Package",
      "Description: Does cool things.",
      "Version: 0.1.0"
    ),
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
  suppressMessages(use_agent(open = FALSE))
  expect_snapshot({
    writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
  })
})

test_that("use_agent() does not insert 'NA' when Description or URL is absent (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: minpkg",
      "Title: Minimal Package",
      "Version: 0.1.0"
    ),
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
  suppressMessages(use_agent(open = FALSE))
  expect_snapshot({
    writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
  })
})

test_that("use_agent() emits an informational message after writing (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Version: 0.1.0"
    ),
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
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

test_that(".use_template() errors on non-logical open (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    "Package: testpkg\nVersion: 0.1.0",
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
  stbl::expect_pkg_error_classes(
    .use_template("AGENTS.md", "AGENTS.md", list(), open = "yes"),
    "stbl",
    "incompatible_type"
  )
})

test_that("use_agent() respects a custom save_as path (#2)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Version: 0.1.0"
    ),
    fs::path(proj_dir, "DESCRIPTION")
  )
  usethis::local_project(proj_dir, quiet = TRUE)
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
