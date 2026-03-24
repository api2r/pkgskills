test_that(".format_now_utc() returns a correctly formatted UTC timestamp (#noissue)", {
  result <- .format_now_utc()
  expect_type(result, "character")
  expect_length(result, 1L)
  expect_match(result, "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$")
})

test_that(".get_desc_fields() returns a named list of non-NA field values (#noissue)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  result <- .get_desc_fields(c("Package", "Title", "URL"))
  expect_mapequal(result, list(Package = "mypkg", Title = "My Package"))
})

test_that(".use_template() errors on non-logical open (#2)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    .use_template("AGENTS.md", "AGENTS.md", open = "yes"),
    "stbl",
    "incompatible_type"
  )
})

test_that(".use_template() creates the file with default data and open args (#2)", {
  proj_dir <- local_pkg()
  suppressMessages(.use_template("AGENTS.md", "AGENTS.md"))
  expect_true(fs::file_exists(fs::path(proj_dir, "AGENTS.md")))
})

test_that(".use_template_as_is() errors on non-logical open (#44)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    .use_template_as_is("AGENTS.md", "AGENTS.md", open = "yes"),
    "stbl",
    "incompatible_type"
  )
})

test_that(".use_template_as_is() writes template content verbatim (#44)", {
  proj_dir <- local_pkg()
  suppressMessages(.use_template_as_is("AGENTS.md", "AGENTS.md"))
  expect_true(fs::file_exists(fs::path(proj_dir, "AGENTS.md")))
  installed <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expected <- readLines(
    system.file("templates", "AGENTS.md", package = "pkgskills"),
    warn = FALSE
  )
  expect_identical(installed, expected)
})

test_that(".use_template_as_is() calls edit_file when open = TRUE (#44)", {
  proj_dir <- local_pkg()
  edited <- character(0)
  local_mocked_bindings(
    edit_file = function(path, ...) {
      edited <<- path
      invisible(path)
    },
    .package = "usethis"
  )
  suppressMessages(.use_template_as_is("AGENTS.md", "AGENTS.md", open = TRUE))
  expect_identical(fs::path_real(edited), fs::path_real(fs::path(proj_dir, "AGENTS.md")))
})
