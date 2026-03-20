test_that(".format_now_utc() returns a correctly formatted UTC timestamp", {
  result <- .format_now_utc()
  expect_type(result, "character")
  expect_length(result, 1L)
  expect_match(result, "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$")
})

test_that(".get_desc_fields() returns a named list of non-NA field values", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  result <- .get_desc_fields(c("Package", "Title", "URL"))
  expect_type(result, "list")
  expect_named(result, c("Package", "Title"))
  expect_equal(result[["Package"]], "mypkg")
  expect_equal(result[["Title"]], "My Package")
})
