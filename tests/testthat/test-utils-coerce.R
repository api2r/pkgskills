test_that(".to_string() tests for non-NULL character scalar (#noissue)", {
  expect_identical(.to_string("hello"), "hello")
  stbl::expect_pkg_error_classes(.to_string(NULL), "stbl", "bad_null")
})

test_that(".to_boolean() returns a logical scalar (#noissue)", {
  expect_identical(.to_boolean(TRUE), TRUE)
  expect_identical(.to_boolean(FALSE), FALSE)
  stbl::expect_pkg_error_classes(.to_boolean(NULL), "stbl", "bad_null")
})
