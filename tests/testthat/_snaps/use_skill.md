# .use_skill() emits a cli_inform message (#6)

    Code
      .use_skill("create-issue", data = list(owner = "testowner", repo = "testrepo",
        repo_id = "R_test", issue_types = list()), open = FALSE)
    Message
      Skill '.github/skills/create-issue/SKILL.md' installed.

# .use_skill() errors when overwrite = FALSE and file exists (#6)

    Code
      (stbl::expect_pkg_error_classes({
        suppressMessages(.use_skill("create-issue", data = list(owner = "o", repo = "r",
          repo_id = "id", issue_types = list()), overwrite = FALSE, open = FALSE))
      }, "pkgskills", "file_exists"))
    Output
      <error/pkgskills-error-file_exists>
      Error:
      ! File 'PATH' already exists.

# .read_skill_trigger() errors when template file not found (#6)

    Code
      (stbl::expect_pkg_error_classes(.read_skill_trigger("/tmp/nonexistent/SKILL.md"),
      "pkgskills", "template_not_found"))
    Output
      <error/pkgskills-error-template_not_found>
      Error:
      ! Template not found: '/tmp/nonexistent/SKILL.md'.

# .read_skill_trigger() errors when front matter is missing (#6)

    Code
      (stbl::expect_pkg_error_classes(.read_skill_trigger(tmp), "pkgskills",
      "no_front_matter"))
    Output
      <error/pkgskills-error-no_front_matter>
      Error:
      ! No YAML front matter found in 'PATH'.

# .read_skill_trigger() errors when trigger field is absent (#6)

    Code
      (stbl::expect_pkg_error_classes(.read_skill_trigger(tmp), "pkgskills",
      "no_trigger"))
    Output
      <error/pkgskills-error-no_trigger>
      Error:
      ! No trigger field in front matter of 'PATH'.

