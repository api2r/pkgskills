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
  stbl::expect_pkg_error_snapshot(
    use_skill_create_issue(open = FALSE),
    "pkgskills",
    "no_bug_reports"
  )
})

test_that(".bug_reports_from_remote() falls back to origin GitHub remote", {
  proj_dir <- local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  local_mocked_bindings(
    git_remote_list = function(...) {
      data.frame(
        name = "origin",
        url = "https://github.com/myorg/mypkg.git",
        fetch = "+refs/heads/*:refs/remotes/origin/*",
        push = "https://github.com/myorg/mypkg.git",
        stringsAsFactors = FALSE
      )
    },
    .package = "gert"
  )
  result <- suppressMessages(.extract_repo_from_desc())
  expect_equal(result$owner, "myorg")
  expect_equal(result$repo, "mypkg")
  desc_content <- readLines(fs::path(proj_dir, "DESCRIPTION"))
  expect_true(any(grepl("BugReports", desc_content)))
})

test_that(".bug_reports_from_remote() prefers upstream over origin", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  local_mocked_bindings(
    git_remote_list = function(...) {
      data.frame(
        name = c("origin", "upstream"),
        url = c(
          "https://github.com/fork/mypkg.git",
          "https://github.com/myorg/mypkg.git"
        ),
        fetch = c(
          "+refs/heads/*:refs/remotes/origin/*",
          "+refs/heads/*:refs/remotes/upstream/*"
        ),
        push = c(
          "https://github.com/fork/mypkg.git",
          "https://github.com/myorg/mypkg.git"
        ),
        stringsAsFactors = FALSE
      )
    },
    .package = "gert"
  )
  result <- suppressMessages(.extract_repo_from_desc())
  expect_equal(result$owner, "myorg")
})

test_that(".bug_reports_from_remote() ignores non-GitHub remotes", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  local_mocked_bindings(
    git_remote_list = function(...) {
      data.frame(
        name = "origin",
        url = "https://gitlab.com/myorg/mypkg.git",
        fetch = "+refs/heads/*:refs/remotes/origin/*",
        push = "https://gitlab.com/myorg/mypkg.git",
        stringsAsFactors = FALSE
      )
    },
    .package = "gert"
  )
  expect_error(
    .extract_repo_from_desc(),
    class = "pkgskills-error-no_bug_reports"
  )
})

test_that(".bug_reports_from_remote() works with SSH remote URL", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
  local_mocked_bindings(
    git_remote_list = function(...) {
      data.frame(
        name = "origin",
        url = "git@github.com:myorg/mypkg.git",
        fetch = "+refs/heads/*:refs/remotes/origin/*",
        push = "git@github.com:myorg/mypkg.git",
        stringsAsFactors = FALSE
      )
    },
    .package = "gert"
  )
  result <- suppressMessages(.extract_repo_from_desc())
  expect_equal(result$owner, "myorg")
  expect_equal(result$repo, "mypkg")
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
  stbl::expect_pkg_error_snapshot(
    use_skill_create_issue(open = FALSE),
    "pkgskills",
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
