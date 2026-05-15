# use_skill_create_issue() errors when BugReports is absent (#6)

    Code
      (expect_pkg_error_classes(use_skill_create_issue(open = FALSE), "pkgskills",
      "no_bug_reports"))
    Output
      <error/pkgskills-error-no_bug_reports>
      Error in `use_skill_create_issue()`:
      ! No BugReports field found in 'DESCRIPTION'.
      i Run `usethis::use_github()` to set one up.

# .bug_reports_from_remote() informs about writes (#81, #82)

    Code
      (expect_pkg_message_classes({
        .extract_repo_from_desc()
      }, "pkgskills", "description_update", "bugreports"))
    Output
      <message/pkgskills-message-description_update-bugreports>
      Message in `.bug_reports_from_remote()`:
      Added BugReports to 'DESCRIPTION': <https://github.com/myorg/mypkg/issues>

# use_skill_create_issue() errors when BugReports is not a GitHub URL (#6)

    Code
      (expect_pkg_error_classes(use_skill_create_issue(open = FALSE), "pkgskills",
      "unsupported_bug_reports"))
    Output
      <error/pkgskills-error-unsupported_bug_reports>
      Error in `use_skill_create_issue()`:
      ! BugReports in 'DESCRIPTION' must be a GitHub issues URL.
      i Run `usethis::use_github()` to set one up.

