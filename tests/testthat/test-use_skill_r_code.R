test_that("use_skill_r_code() installs skill at correct path (#17)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_r_code(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/r-code/SKILL.md"))
  )
})

test_that("use_skill_r_code() returns path invisibly (#17)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_r_code(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/r-code/SKILL.md"))
  )
})

test_that("use_skill_r_code() emits install message (#17)", {
  local_pkg()
  expect_snapshot(use_skill_r_code(open = FALSE))
})
