test_that("use_github_copilot_code_review() installs copilot-instructions.md (#89)", {
  proj_dir <- local_pkg()
  suppressMessages(use_github_copilot_code_review(open = FALSE))
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    ".github/copilot-instructions.md"
  )))
})

test_that("use_github_copilot_code_review() returns path invisibly (#89)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_github_copilot_code_review(
    open = FALSE
  )))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/copilot-instructions.md"))
  )
})

test_that("use_github_copilot_code_review() errors if file exists and overwrite = FALSE (#89)", {
  local_pkg(".github/copilot-instructions.md" = "# existing")
  expect_error(
    suppressMessages(use_github_copilot_code_review(open = FALSE)),
    class = "pkgskills-error-file_exists"
  )
})

test_that("use_github_copilot_code_review() overwrites file when overwrite = TRUE (#89)", {
  proj_dir <- local_pkg(".github/copilot-instructions.md" = "# old")
  suppressMessages(use_github_copilot_code_review(
    overwrite = TRUE,
    open = FALSE
  ))
  content <- readLines(fs::path(proj_dir, ".github/copilot-instructions.md"))
  expect_false(identical(content, "# old"))
  expect_true(any(grepl("man/\\*\\.Rd", content)))
})
