test_that("use_skill_r_code() installs skill at correct path (#19)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_r_code(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/r-code/SKILL.md"))
  )
})

test_that("use_skill_r_code() returns path invisibly (#19)", {
  proj_dir <- local_pkg()
  result <- withVisible(suppressMessages(use_skill_r_code(open = FALSE)))
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/r-code/SKILL.md"))
  )
})

test_that("use_skill_r_code() emits install message (#19)", {
  local_pkg()
  expect_snapshot(use_skill_r_code(open = FALSE))
})

test_that("use_skill_r_code() creates R/aaa-conditions.R when absent (#19)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_r_code(open = FALSE))
  expect_true(fs::file_exists(fs::path(proj_dir, "R/aaa-conditions.R")))
})

test_that("use_skill_r_code() substitutes Package into aaa-conditions.R (#19)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_r_code(open = FALSE))
  content <- readLines(fs::path(proj_dir, "R/aaa-conditions.R"))
  expect_match(content, "mypkg", all = FALSE)
  expect_no_match(content, "pkgskills", all = FALSE)
})

test_that("use_skill_r_code() does not overwrite existing R/aaa-conditions.R (#19)", {
  proj_dir <- local_pkg(
    "R/aaa-conditions.R" = "# custom content"
  )
  suppressMessages(use_skill_r_code(open = FALSE))
  content <- readLines(fs::path(proj_dir, "R/aaa-conditions.R"))
  expect_equal(content, "# custom content")
})

test_that("use_skill_r_code() does not emit conditions message when file exists (#19)", {
  proj_dir <- local_pkg(
    "R/aaa-conditions.R" = "# custom content"
  )
  msgs <- character()
  withCallingHandlers(
    use_skill_r_code(open = FALSE),
    message = function(m) {
      msgs <<- c(msgs, conditionMessage(m))
      invokeRestart("muffleMessage")
    }
  )
  expect_false(any(grepl("aaa-conditions", msgs)))
})
