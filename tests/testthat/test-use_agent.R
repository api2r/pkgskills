# Helpers that replicate .use_template / .proj_path behaviour without usethis,
# allowing tests to run without usethis installed.
.render_template <- function(save_as, data, open) {
  template_path <- system.file("templates/AGENTS.md", package = "pkgskills")
  template <- paste(readLines(template_path, warn = FALSE), collapse = "\n")
  rendered <- whisker::whisker.render(template, data)
  out_path <- file.path(getwd(), save_as)
  dir.create(dirname(out_path), recursive = TRUE, showWarnings = FALSE)
  writeLines(strsplit(rendered, "\n")[[1]], out_path)
  invisible(save_as)
}

.abs_path <- function(save_as) file.path(getwd(), save_as)

test_that("use_agent() writes AGENTS.md and returns the path invisibly (#1)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Description: A package for testing.",
      "Version: 0.1.0",
      "URL: https://example.com"
    ),
    file.path(proj_dir, "DESCRIPTION")
  )

  local_mocked_bindings(
    .use_template = .render_template,
    .proj_path = .abs_path
  )

  result <- withr::with_dir(proj_dir, suppressMessages(use_agent(open = FALSE)))

  expect_true(file.exists(result))
  expect_identical(basename(result), "AGENTS.md")
})

test_that("use_agent() substitutes Package and Title from DESCRIPTION (#1)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: coolpkg",
      "Title: A Cool Package",
      "Description: Does cool things.",
      "Version: 0.1.0",
      "URL: https://coolpkg.example.com"
    ),
    file.path(proj_dir, "DESCRIPTION")
  )

  local_mocked_bindings(
    .use_template = .render_template,
    .proj_path = .abs_path
  )

  withr::with_dir(proj_dir, suppressMessages(use_agent(open = FALSE)))

  content <- readLines(file.path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("coolpkg", content)))
  expect_true(any(grepl("A Cool Package", content)))
})

test_that("use_agent() does not insert 'NA' when Description or URL is absent (#1)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: minpkg",
      "Title: Minimal Package",
      "Version: 0.1.0"
    ),
    file.path(proj_dir, "DESCRIPTION")
  )

  local_mocked_bindings(
    .use_template = .render_template,
    .proj_path = .abs_path
  )

  expect_no_error(
    withr::with_dir(proj_dir, suppressMessages(use_agent(open = FALSE)))
  )

  content <- paste(readLines(file.path(proj_dir, "AGENTS.md")), collapse = "\n")
  expect_false(grepl("\\bNA\\b", content))
})

test_that("use_agent() emits an informational message after writing (#1)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Version: 0.1.0"
    ),
    file.path(proj_dir, "DESCRIPTION")
  )

  local_mocked_bindings(
    .use_template = .render_template,
    .proj_path = .abs_path
  )

  expect_message(
    withr::with_dir(proj_dir, use_agent(open = FALSE)),
    "AGENTS.md"
  )
})

test_that("use_agent() respects a custom save_as path (#1)", {
  proj_dir <- withr::local_tempdir()
  writeLines(
    c(
      "Package: mypkg",
      "Title: My Test Package",
      "Version: 0.1.0"
    ),
    file.path(proj_dir, "DESCRIPTION")
  )

  local_mocked_bindings(
    .use_template = .render_template,
    .proj_path = .abs_path
  )

  result <- withr::with_dir(proj_dir, {
    suppressMessages(use_agent(save_as = "docs/AGENTS.md", open = FALSE))
  })

  expect_true(file.exists(result))
  expect_identical(basename(result), "AGENTS.md")
  expect_true(file.exists(file.path(proj_dir, "docs/AGENTS.md")))
})
