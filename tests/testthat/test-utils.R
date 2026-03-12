test_that(".to_string() tests for non-NULL character scalar (#noissue)", {
  expect_identical(.to_string("hello"), "hello")
  stbl::expect_pkg_error_classes(.to_string(NULL), "stbl", "bad_null")
})
