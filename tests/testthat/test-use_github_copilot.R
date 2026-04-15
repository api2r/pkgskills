test_that("use_github_copilot() installs copilot-setup-steps.yml (#25, #84, #89)", {
  proj_dir <- local_pkg()
  local_gh_mock()
  suppressWarnings(suppressMessages(use_github_copilot(open = FALSE)))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
    )
  )
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    ".github/copilot-instructions.md"
  )))
})

test_that("use_github_copilot() returns path to copilot-setup-steps.yml invisibly (#25)", {
  proj_dir <- local_pkg()
  local_gh_mock()
  result <- withVisible(suppressWarnings(suppressMessages(use_github_copilot(
    open = FALSE
  ))))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(
      proj_dir,
      ".github/workflows/copilot-setup-steps.yml"
    ))
  )
})

test_that("use_github_copilot() errors if copilot-setup-steps.yml exists and overwrite = FALSE (#25)", {
  local_pkg(".github/workflows/copilot-setup-steps.yml" = "# existing")
  local_gh_mock()
  expect_error(
    suppressWarnings(suppressMessages(use_github_copilot(open = FALSE))),
    class = "pkgskills-error-file_exists"
  )
})

test_that("use_github_copilot() overwrites files when overwrite = TRUE (#25, #84)", {
  proj_dir <- local_pkg(
    ".github/workflows/copilot-setup-steps.yml" = "# old"
  )
  local_gh_mock()
  suppressWarnings(suppressMessages(use_github_copilot(
    overwrite = TRUE,
    open = FALSE
  )))
  workflow_content <- readLines(
    fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
  )
  expect_false(identical(workflow_content, "# old"))
})

test_that("use_github_copilot() preserves ${{ }} in copilot-setup-steps.yml (#44)", {
  proj_dir <- local_pkg()
  local_gh_mock()
  suppressWarnings(suppressMessages(use_github_copilot(open = FALSE)))
  workflow_content <- readLines(
    fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
  )
  expect_true(any(grepl("${{", workflow_content, fixed = TRUE)))
})
