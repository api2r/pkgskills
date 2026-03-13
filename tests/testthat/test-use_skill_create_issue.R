test_that("use_skill_create_issue() errors when BugReports is absent (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  expect_snapshot(
    (expect_error(
      use_skill_create_issue(open = FALSE),
      class = "pkgskills-error"
    ))
  )
})

test_that("use_skill_create_issue() errors when BugReports is not a GitHub URL (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://gitlab.com/myorg/mypkg/issues"
    )
  )
  expect_snapshot(
    (expect_error(
      use_skill_create_issue(open = FALSE),
      class = "pkgskills-error"
    ))
  )
})

test_that("use_skill_create_issue() calls gh::gh() with correct queries (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://github.com/myorg/mypkg/issues"
    )
  )
  gh_calls <- list()
  local_mocked_bindings(
    gh = function(...) {
      args <- list(...)
      gh_calls[[length(gh_calls) + 1]] <<- args
      if (grepl("issueTypes", args$query)) {
        list(data = list(repository = list(issueTypes = list(nodes = list()))))
      } else {
        list(data = list(repository = list(id = "R_testid")))
      }
    },
    .package = "gh"
  )
  suppressMessages(use_skill_create_issue(open = FALSE))
  expect_length(gh_calls, 2L)
  expect_true(any(vapply(
    gh_calls,
    function(x) grepl("issueTypes", x$query),
    logical(1)
  )))
  expect_true(any(vapply(
    gh_calls,
    function(x) grepl("myorg", x$query),
    logical(1)
  )))
  expect_true(any(vapply(
    gh_calls,
    function(x) grepl("mypkg", x$query),
    logical(1)
  )))
})

test_that("use_skill_create_issue() passes correct data to .use_skill() (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://github.com/myorg/mypkg/issues"
    )
  )
  local_mocked_bindings(
    gh = function(...) {
      args <- list(...)
      if (grepl("issueTypes", args$query)) {
        list(
          data = list(
            repository = list(
              issueTypes = list(
                nodes = list(
                  list(
                    name = "Feature",
                    id = "IT_feat",
                    description = "New stuff"
                  )
                )
              )
            )
          )
        )
      } else {
        list(data = list(repository = list(id = "R_myid")))
      }
    },
    .package = "gh"
  )
  captured_data <- NULL
  local_mocked_bindings(
    .use_skill = function(skill, data, ...) {
      captured_data <<- data
      invisible(usethis::proj_path(".github/skills/create-issue/SKILL.md"))
    }
  )
  suppressMessages(use_skill_create_issue(open = FALSE))
  expect_equal(captured_data$owner, "myorg")
  expect_equal(captured_data$repo, "mypkg")
  expect_equal(captured_data$repo_id, "R_myid")
  expect_equal(captured_data$issue_types[[1]]$name, "Feature")
  expect_true(grepl("UTC$", captured_data$update_time))
  expect_match(
    captured_data$update_time,
    "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$"
  )
})

test_that("use_skill_create_issue() returns path invisibly (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://github.com/myorg/mypkg/issues"
    )
  )
  local_mocked_bindings(
    gh = function(...) {
      args <- list(...)
      if (grepl("issueTypes", args$query)) {
        list(data = list(repository = list(issueTypes = list(nodes = list()))))
      } else {
        list(data = list(repository = list(id = "R_testid")))
      }
    },
    .package = "gh"
  )
  result <- withVisible(suppressMessages(use_skill_create_issue(open = FALSE)))
  expect_false(result$visible)
})

test_that("use_skill_create_issue() errors on non-scalar target_dir (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://github.com/myorg/mypkg/issues"
    )
  )
  stbl::expect_pkg_error_classes(
    use_skill_create_issue(target_dir = c("a", "b"), open = FALSE),
    "stbl",
    "non_scalar"
  )
})

test_that("use_skill_create_issue() errors on non-logical overwrite (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0",
      "BugReports: https://github.com/myorg/mypkg/issues"
    )
  )
  stbl::expect_pkg_error_classes(
    use_skill_create_issue(overwrite = "yes", open = FALSE),
    "stbl",
    "incompatible_type"
  )
})
