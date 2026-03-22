test_that("use_github_copilot() installs copilot-setup-steps.yml (#25)", {
  proj_dir <- local_pkg()
  suppressMessages(use_github_copilot(open = FALSE))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
    )
  )
})

test_that("use_github_copilot() installs install/action.yml (#25)", {
  proj_dir <- local_pkg()
  suppressMessages(use_github_copilot(open = FALSE))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, ".github/workflows/install/action.yml")
    )
  )
})

test_that("use_github_copilot() returns path to copilot-setup-steps.yml invisibly (#25)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_github_copilot(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    result$value,
    fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
  )
})

test_that("use_github_copilot() errors if copilot-setup-steps.yml exists and overwrite = FALSE (#25)", {
  local_pkg(".github/workflows/copilot-setup-steps.yml" = "# existing")
  expect_error(
    suppressMessages(use_github_copilot(open = FALSE)),
    class = "pkgskills-error-file_exists"
  )
})

test_that("use_github_copilot() errors if install/action.yml exists and overwrite = FALSE (#25)", {
  local_pkg(".github/workflows/install/action.yml" = "# existing")
  expect_error(
    suppressMessages(use_github_copilot(open = FALSE)),
    class = "pkgskills-error-file_exists"
  )
})

test_that("use_github_copilot() overwrites files when overwrite = TRUE (#25)", {
  proj_dir <- local_pkg(
    ".github/workflows/copilot-setup-steps.yml" = "# old",
    ".github/workflows/install/action.yml" = "# old"
  )
  suppressMessages(use_github_copilot(overwrite = TRUE, open = FALSE))
  workflow_content <- readLines(
    fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
  )
  expect_false(identical(workflow_content, "# old"))
})

test_that("use_github_copilot() checks both paths before writing either (#25)", {
  # install/action.yml exists, copilot-setup-steps.yml does not
  # Should error before writing copilot-setup-steps.yml
  proj_dir <- local_pkg(".github/workflows/install/action.yml" = "# existing")
  expect_error(
    suppressMessages(use_github_copilot(open = FALSE)),
    class = "pkgskills-error-file_exists"
  )
  expect_false(
    fs::file_exists(
      fs::path(proj_dir, ".github/workflows/copilot-setup-steps.yml")
    )
  )
})
