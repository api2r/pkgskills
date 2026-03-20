test_that("use_skill_search_code() installs skill at correct path (#12)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_search_code(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/search-code/SKILL.md"))
  )
})

test_that("use_skill_search_code() returns path invisibly (#12)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_search_code(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/search-code/SKILL.md"))
  )
})
