# .use_skill() emits a cli_inform message (#3)

    Code
      .use_skill("create-issue", data = list(owner = "testowner", repo = "testrepo",
        repo_id = "R_test", issue_types = list()), open = FALSE)
    Message
      Skill '.github/skills/create-issue/SKILL.md' installed.

