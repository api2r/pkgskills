test_that(".format_now_utc() returns a correctly formatted UTC timestamp (#noissue)", {
  result <- .format_now_utc()
  expect_type(result, "character")
  expect_length(result, 1L)
  expect_match(result, "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$")
})
