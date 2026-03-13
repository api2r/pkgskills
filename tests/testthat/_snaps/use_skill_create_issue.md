# use_skill_create_issue() errors when BugReports is absent (#3)

    Code
      (expect_error(use_skill_create_issue(open = FALSE), class = "pkgskills-error"))
    Output
      <error/pkgskills-error-no_bug_reports>
      Error in `use_skill_create_issue()`:
      ! No BugReports field found in 'DESCRIPTION'.
      i Run `usethis::use_github()` to set one up.

# use_skill_create_issue() errors when BugReports is not a GitHub URL (#3)

    Code
      (expect_error(use_skill_create_issue(open = FALSE), class = "pkgskills-error"))
    Output
      <error/pkgskills-error-invalid_bug_reports>
      Error in `use_skill_create_issue()`:
      ! BugReports in 'DESCRIPTION' must be a GitHub issues URL.
      i Run `usethis::use_github()` to set one up.

