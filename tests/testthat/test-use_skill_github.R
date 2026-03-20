test_that("use_skill_github() installs skill at correct path", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_github(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/github/SKILL.md"))
  )
})

test_that("use_skill_github() returns path invisibly", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_github(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/github/SKILL.md"))
  )
})
