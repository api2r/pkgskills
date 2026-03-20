test_that(".format_now_utc() returns a correctly formatted UTC timestamp (#noissue)", {
  result <- .format_now_utc()
  expect_type(result, "character")
  expect_length(result, 1L)
  expect_match(result, "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$")
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
