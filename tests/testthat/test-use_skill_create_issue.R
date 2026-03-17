test_that("use_skill_create_issue() errors on non-scalar target_dir (#6)", {
  local_pkg()
  local_gh_mock()
  stbl::expect_pkg_error_classes(
    use_skill_create_issue(target_dir = c("a", "b"), open = FALSE),
    "stbl",
    "non_scalar"
  )
})

test_that("use_skill_create_issue() errors on non-logical overwrite (#6)", {
  local_pkg()
  local_gh_mock()
  stbl::expect_pkg_error_classes(
    use_skill_create_issue(overwrite = "yes", open = FALSE),
    "stbl",
    "incompatible_type"
  )
})

test_that("use_skill_create_issue() errors when BugReports is absent (#6)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  expect_pkg_error_snapshot(
    use_skill_create_issue(open = FALSE),
    "no_bug_reports"
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
  expect_pkg_error_snapshot(
    use_skill_create_issue(open = FALSE),
    "unsupported_bug_reports"
  )
})

test_that("use_skill_create_issue() passes correct data to .use_skill() (#6)", {
  local_pkg()
  local_gh_mock(
    issue_types = list(
      list(name = "Feature", id = "IT_feat", description = "New stuff")
    ),
    repo_id = "R_myid"
  )
  local_mocked_bindings(
    .use_skill = function(skill, data, ...) {
      expect_equal(data$owner, "myorg")
      expect_equal(data$repo, "mypkg")
      expect_equal(data$repo_id, "R_myid")
      expect_equal(data$issue_types[[1]]$name, "Feature")
      expect_match(
        data$update_time,
        "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} UTC$"
      )
      invisible(usethis::proj_path(".github/skills/create-issue/SKILL.md"))
    }
  )
  suppressMessages(use_skill_create_issue(open = FALSE))
})

test_that("use_skill_create_issue() returns path invisibly (#6)", {
  local_pkg()
  local_gh_mock()
  result <- withVisible(suppressMessages(use_skill_create_issue(open = FALSE)))
  expect_false(result$visible)
})
