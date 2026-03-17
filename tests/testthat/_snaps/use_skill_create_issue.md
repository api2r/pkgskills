# use_skill_create_issue() errors when BugReports is absent (#6)

    Code
      (stbl::expect_pkg_error_classes(use_skill_create_issue(open = FALSE),
      "pkgskills", "no_bug_reports"))
    Output
      <error/pkgskills-error-no_bug_reports>
      Error in `use_skill_create_issue()`:
      ! No BugReports field found in 'DESCRIPTION'.
      i Run `usethis::use_github()` to set one up.

# use_skill_create_issue() errors when BugReports is not a GitHub URL (#6)

    Code
      (stbl::expect_pkg_error_classes(use_skill_create_issue(open = FALSE),
      "pkgskills", "unsupported_bug_reports"))
    Output
      <error/pkgskills-error-unsupported_bug_reports>
      Error in `use_skill_create_issue()`:
      ! BugReports in 'DESCRIPTION' must be a GitHub issues URL.
      i Run `usethis::use_github()` to set one up.

