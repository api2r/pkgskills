test_that("use_github_copilot_whitelist() informs user when API fails (#79)", {
  local_pkg()
  local_mocked_bindings(
    .call_gh = function(...) {
      rlang::abort("API not available")
    }
  )
  expect_message(
    use_github_copilot_whitelist(gh_token = "test-token"),
    "myorg/mypkg"
  )
})

test_that("use_github_copilot_whitelist() message contains allowlist URL (#79)", {
  local_pkg()
  local_mocked_bindings(
    .call_gh = function(...) {
      rlang::abort("API not available")
    }
  )
  expect_message(
    use_github_copilot_whitelist(gh_token = "test-token"),
    "https://github.com/myorg/mypkg/settings/copilot/coding_agent/allowlist"
  )
})

test_that("use_github_copilot_whitelist() message contains allowlist entries (#79)", {
  local_pkg()
  local_mocked_bindings(
    .call_gh = function(...) {
      rlang::abort("API not available")
    }
  )
  msgs <- capture_messages(
    use_github_copilot_whitelist(
      allowlist = c("example.com", "other.org"),
      gh_token = "test-token"
    )
  )
  combined <- paste(msgs, collapse = "")
  expect_true(grepl("example.com", combined, fixed = TRUE))
  expect_true(grepl("other.org", combined, fixed = TRUE))
})

test_that("use_github_copilot_whitelist() returns NULL invisibly on API failure (#79)", {
  local_pkg()
  local_mocked_bindings(
    .call_gh = function(...) {
      rlang::abort("API not available")
    }
  )
  result <- withVisible(suppressMessages(
    use_github_copilot_whitelist(gh_token = "test-token")
  ))
  expect_false(result$visible)
  expect_null(result$value)
})

test_that("use_github_copilot_whitelist() returns NULL invisibly on API success (#79)", {
  local_pkg()
  local_mocked_bindings(
    .call_gh = function(...) {
      list(status = "ok")
    }
  )
  result <- withVisible(suppressMessages(
    use_github_copilot_whitelist(gh_token = "test-token")
  ))
  expect_false(result$visible)
  expect_null(result$value)
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
