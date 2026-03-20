test_that("use_skill_tdd_workflow() creates skill file at correct path (#11)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_tdd_workflow(open = FALSE))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, ".github/skills/tdd-workflow/SKILL.md")
    )
  )
})

test_that("use_skill_tdd_workflow() returns path invisibly (#11)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_tdd_workflow(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/tdd-workflow/SKILL.md"))
  )
})

test_that("use_skill_tdd_workflow() renders package name into skill file (#11)", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: coolpkg",
      "Title: A Cool Package",
      "Version: 0.1.0"
    )
  )
  suppressMessages(use_skill_tdd_workflow(open = FALSE))
  content <- readLines(
    fs::path(proj_dir, ".github/skills/tdd-workflow/SKILL.md")
  )
  expect_true(any(grepl("coolpkg", content)))
  expect_false(any(grepl("\\{\\{\\{package\\}\\}\\}", content)))
})

test_that("use_skill_tdd_workflow() creates helper-expectations.R (#11)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_tdd_workflow(open = FALSE))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, "tests/testthat/helper-expectations.R")
    )
  )
})

test_that("use_skill_tdd_workflow() renders package name into helper-expectations.R (#11)", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: coolpkg",
      "Title: A Cool Package",
      "Version: 0.1.0"
    )
  )
  suppressMessages(use_skill_tdd_workflow(open = FALSE))
  content <- readLines(
    fs::path(proj_dir, "tests/testthat/helper-expectations.R")
  )
  expect_true(any(grepl('package = "coolpkg"', content, fixed = TRUE)))
})

test_that("use_skill_tdd_workflow() does not overwrite existing helper-expectations.R (#11)", {
  helper_content <- c("# My custom helper", "custom_function <- function() {}")
  proj_dir <- local_pkg(
    "tests/testthat/helper-expectations.R" = helper_content
  )
  suppressMessages(use_skill_tdd_workflow(open = FALSE))
  content <- readLines(
    fs::path(proj_dir, "tests/testthat/helper-expectations.R")
  )
  expect_equal(content, helper_content)
})

test_that("use_skill_tdd_workflow() emits inform message when helper is created (#11)", {
  local_pkg()
  expect_snapshot(use_skill_tdd_workflow(open = FALSE))
})

test_that("use_skill_tdd_workflow() does not emit helper message when it already exists (#11)", {
  local_pkg(
    "tests/testthat/helper-expectations.R" = "# existing"
  )
  expect_snapshot(use_skill_tdd_workflow(open = FALSE))
})

test_that("use_skill_tdd_workflow() errors on non-scalar target_dir (#11)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    use_skill_tdd_workflow(target_dir = c("a", "b"), open = FALSE),
    "stbl",
    "non_scalar"
  )
})

test_that("use_skill_tdd_workflow() errors on non-logical overwrite (#11)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    use_skill_tdd_workflow(overwrite = "yes", open = FALSE),
    "stbl",
    "incompatible_type"
  )
})
