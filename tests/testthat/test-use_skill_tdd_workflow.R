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

test_that("use_skill_tdd_workflow() emits inform message (#11)", {
  local_pkg()
  expect_snapshot(use_skill_tdd_workflow(open = FALSE))
})

test_that("use_skill_tdd_workflow() errors when Package field is absent (#11)", {
  local_pkg()
  local_mocked_bindings(
    .get_desc_fields = function(...) list()
  )
  expect_pkg_error_snapshot(
    use_skill_tdd_workflow(open = FALSE),
    "no_package_field"
  )
})
