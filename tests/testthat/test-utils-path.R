test_that(".path_pkg() returns an existing path within pkgskills (#noissue)", {
  path <- .path_pkg()
  expect_type(path, "character")
  expect_true(fs::dir_exists(path))
})

test_that(".path_template() returns a path under the templates directory (#noissue)", {
  path <- .path_template()
  expect_true(fs::dir_exists(path))
  expect_match(path, "templates")
})

test_that(".path_proj_save_as() returns the project-relative path (#noissue)", {
  proj_dir <- local_pkg()
  result <- .path_proj_save_as("output.md", overwrite = TRUE)
  # Write so path_real() works.
  writeLines("sample", result)
  expect_identical(
    fs::path_real(result),
    fs::path_real(fs::path(proj_dir, "output.md"))
  )
})

test_that(".path_proj_save_as() errors when file exists and overwrite = FALSE (#noissue)", {
  proj_dir <- local_pkg()
  output_path <- fs::path(proj_dir, "output.md")
  writeLines("content", output_path)
  output_path <- fs::path_real(output_path)
  stbl::expect_pkg_error_snapshot(
    .path_proj_save_as("output.md", overwrite = FALSE),
    "pkgskills",
    "file_exists",
    transform = .transform_path(output_path)
  )
})

test_that(".check_path_writable() returns NULL invisibly when path does not exist (#noissue)", {
  tmp <- withr::local_tempfile()
  result <- withVisible(.check_path_writable(tmp, overwrite = FALSE))
  expect_null(result$value)
  expect_false(result$visible)
})

test_that(".check_path_writable() deletes existing file when overwrite = TRUE (#noissue)", {
  tmp <- withr::local_tempfile()
  writeLines("content", tmp)
  expect_true(fs::file_exists(tmp))
  .check_path_writable(tmp, overwrite = TRUE)
  expect_false(fs::file_exists(tmp))
})

test_that(".check_path_writable() errors when file exists and overwrite = FALSE (#noissue)", {
  tmp <- withr::local_tempfile()
  writeLines("content", tmp)
  stbl::expect_pkg_error_snapshot(
    .check_path_writable(tmp, overwrite = FALSE),
    "pkgskills",
    "file_exists",
    transform = .transform_path(tmp)
  )
})
