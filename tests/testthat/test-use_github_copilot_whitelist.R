test_that("use_github_copilot_whitelist() warns and informs user (#79)", {
  local_pkg()
  expect_warning(
    expect_message(
      use_github_copilot_whitelist(gh_token = "test-token"),
      "myorg/mypkg"
    ),
    "cannot be updated through the api"
  )
})

test_that("use_github_copilot_whitelist() message contains allowlist URL (#79)", {
  local_pkg()
  suppressWarnings(expect_message(
    use_github_copilot_whitelist(gh_token = "test-token"),
    "https://github.com/myorg/mypkg/settings/copilot/coding_agent/allowlist"
  ))
})

test_that("use_github_copilot_whitelist() message contains allowlist entries (#79)", {
  local_pkg()
  msgs <- suppressWarnings(capture_messages(
    use_github_copilot_whitelist(
      allowlist = c("example.com", "other.org"),
      gh_token = "test-token"
    )
  ))
  combined <- paste(msgs, collapse = "")
  expect_true(grepl("example.com", combined, fixed = TRUE))
  expect_true(grepl("other.org", combined, fixed = TRUE))
})

test_that("use_github_copilot_whitelist() returns NULL invisibly (#79)", {
  local_pkg()
  result <- withVisible(suppressWarnings(suppressMessages(
    use_github_copilot_whitelist(gh_token = "test-token")
  )))
  expect_false(result$visible)
  expect_null(result$value)
})

test_that("use_github_copilot_whitelist() aborts with bad_endpoint subclass (#79)", {
  local_pkg()
  expect_error(
    .set_copilot_allowlist("owner", "repo", character(0), "token"),
    class = "pkgskills-error-bad_endpoint"
  )
})

test_that("use_github_copilot_whitelist() errors if no BugReports in DESCRIPTION (#79)", {
  local_pkg(
    DESCRIPTION = c(
      "Package: mypkg",
      "Title: My Test Package",
      "Description: A package for testing.",
      "Version: 0.1.0"
    )
  )
  expect_error(
    use_github_copilot_whitelist(gh_token = "test-token"),
    class = "pkgskills-error-no_bug_reports"
  )
})
