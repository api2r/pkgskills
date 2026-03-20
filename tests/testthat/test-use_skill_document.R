test_that("use_skill_document() installs skill at correct path (#9)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_document(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/document/SKILL.md"))
  )
})

test_that("use_skill_document() returns path invisibly (#9)", {
  local_pkg()
  result <- withVisible(suppressMessages(use_skill_document(open = FALSE)))
  expect_false(result$visible)
})

test_that("use_skill_document() creates R/aaa-shared_params.R when absent (#9)", {
  proj_dir <- local_pkg()
  suppressMessages(use_skill_document(open = FALSE))
  expect_true(
    fs::file_exists(fs::path(proj_dir, "R/aaa-shared_params.R"))
  )
})

test_that("use_skill_document() does not overwrite existing R/aaa-shared_params.R (#9)", {
  proj_dir <- local_pkg(
    "R/aaa-shared_params.R" = "# custom content"
  )
  suppressMessages(use_skill_document(open = FALSE))
  content <- readLines(fs::path(proj_dir, "R/aaa-shared_params.R"))
  expect_equal(content, "# custom content")
})

test_that("use_skill_document() emits message when aaa-shared_params.R is created (#9)", {
  local_pkg()
  expect_snapshot(use_skill_document(open = FALSE))
})

test_that("use_skill_document() does not emit shared_params message when file exists (#9)", {
  proj_dir <- local_pkg(
    "R/aaa-shared_params.R" = "# custom content"
  )
  msgs <- character()
  withCallingHandlers(
    use_skill_document(open = FALSE),
    message = function(m) {
      msgs <<- c(msgs, conditionMessage(m))
      invokeRestart("muffleMessage")
    }
  )
  expect_false(any(grepl("aaa-shared_params", msgs)))
})
