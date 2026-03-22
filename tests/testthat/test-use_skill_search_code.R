test_that("use_skill_search_code() installs skill at correct path (#12)", {
  skip_if_not_installed("astgrepr")
  proj_dir <- local_pkg()
  suppressMessages(use_skill_search_code(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/search-code/SKILL.md"))
  )
})

test_that("use_skill_search_code() returns path invisibly (#12)", {
  skip_if_not_installed("astgrepr")
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_search_code(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/search-code/SKILL.md"))
  )
})

test_that("use_skill_search_code() adds astgrepr to Suggests when absent (#12)", {
  skip_if_not_installed("astgrepr")
  proj_dir <- local_pkg()
  suppressMessages(use_skill_search_code(open = FALSE))
  deps <- desc::desc(fs::path(proj_dir, "DESCRIPTION"))$get_deps()
  astgrepr_row <- deps[deps$package == "astgrepr", ]
  expect_equal(nrow(astgrepr_row), 1L)
  expect_equal(astgrepr_row$type, "Suggests")
})

test_that("use_skill_search_code() does not modify DESCRIPTION when astgrepr already in Suggests (#12)", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Test Package",
      "Description: A package for testing.",
      "Version: 0.1.0",
      "Suggests:",
      "    astgrepr"
    )
  )
  suppressMessages(use_skill_search_code(open = FALSE))
  deps <- desc::desc(fs::path(proj_dir, "DESCRIPTION"))$get_deps()
  astgrepr_rows <- deps[deps$package == "astgrepr", ]
  expect_equal(nrow(astgrepr_rows), 1L)
  expect_equal(astgrepr_rows$type, "Suggests")
})

test_that("use_skill_search_code() does not modify DESCRIPTION when astgrepr already in Imports (#12)", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Test Package",
      "Description: A package for testing.",
      "Version: 0.1.0",
      "Imports:",
      "    astgrepr"
    )
  )
  suppressMessages(use_skill_search_code(open = FALSE))
  deps <- desc::desc(fs::path(proj_dir, "DESCRIPTION"))$get_deps()
  astgrepr_rows <- deps[deps$package == "astgrepr", ]
  expect_equal(nrow(astgrepr_rows), 1L)
  expect_equal(astgrepr_rows$type, "Imports")
})
