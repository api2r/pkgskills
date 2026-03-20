test_that("use_skill_implement_issue() installs skill at correct path", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_implement_issue(open = FALSE))
  expect_true(
    fs::file_exists(
      fs::path(proj_dir, ".github/skills/implement-issue/SKILL.md")
    )
  )
})

test_that("use_skill_implement_issue() returns path invisibly", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_implement_issue(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(
      fs::path(proj_dir, ".github/skills/implement-issue/SKILL.md")
    )
  )
})
