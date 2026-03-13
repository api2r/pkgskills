test_that(".use_skill() returns path invisibly (#3)", {
  proj_dir <- local_pkg()
  result <- withVisible(
    suppressMessages(
      .use_skill(
        "create-issue",
        data = list(
          owner = "testowner",
          repo = "testrepo",
          repo_id = "R_test",
          issue_types = list(list(
            name = "Feature",
            id = "IT_1",
            description = "New stuff"
          ))
        ),
        open = FALSE
      )
    )
  )
  expect_false(result$visible)
  expect_equal(
    fs::path_real(result$value),
    fs::path_real(fs::path(proj_dir, ".github/skills/create-issue/SKILL.md"))
  )
})

test_that(".use_skill() creates file at correct path with use_skills_subdir = TRUE (#3)", {
  proj_dir <- local_pkg()
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "testowner",
        repo = "testrepo",
        repo_id = "R_test",
        issue_types = list(list(
          name = "Feature",
          id = "IT_1",
          description = "New stuff"
        ))
      ),
      open = FALSE
    )
  )
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/skills/create-issue/SKILL.md"))
  )
})

test_that(".use_skill() creates file at correct path with use_skills_subdir = FALSE (#3)", {
  proj_dir <- local_pkg()
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "testowner",
        repo = "testrepo",
        repo_id = "R_test",
        issue_types = list(list(
          name = "Feature",
          id = "IT_1",
          description = "New stuff"
        ))
      ),
      use_skills_subdir = FALSE,
      open = FALSE
    )
  )
  expect_true(
    fs::file_exists(fs::path(proj_dir, ".github/create-issue/SKILL.md"))
  )
})

test_that(".use_skill() renders template variables into skill file (#3)", {
  proj_dir <- local_pkg()
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "myowner",
        repo = "myrepo",
        repo_id = "R_myid",
        issue_types = list(
          list(name = "Feature", id = "IT_feat", description = "New features"),
          list(name = "Bug", id = "IT_bug", description = "Broken things")
        )
      ),
      open = FALSE
    )
  )
  content <- readLines(fs::path(
    proj_dir,
    ".github/skills/create-issue/SKILL.md"
  ))
  expect_true(any(grepl("myowner", content)))
  expect_true(any(grepl("myrepo", content)))
  expect_true(any(grepl("R_myid", content)))
  expect_true(any(grepl("IT_feat", content)))
  expect_true(any(grepl("IT_bug", content)))
})

test_that(".use_skill() emits a cli_inform message (#3)", {
  local_pkg()
  expect_snapshot(
    .use_skill(
      "create-issue",
      data = list(
        owner = "testowner",
        repo = "testrepo",
        repo_id = "R_test",
        issue_types = list()
      ),
      open = FALSE
    )
  )
})

test_that(".use_skill() upserts into AGENTS.md when it exists (#3)", {
  proj_dir <- local_pkg(
    "AGENTS.md" = c(
      "## Skills",
      "",
      "| Triggers | Path |",
      "|----------|------|"
    )
  )
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "o",
        repo = "r",
        repo_id = "id",
        issue_types = list()
      ),
      open = FALSE
    )
  )
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("create GitHub issues", content)))
  expect_true(any(grepl(
    "@.github/skills/create-issue/SKILL.md",
    content,
    fixed = TRUE
  )))
})

test_that(".use_skill() creates ## Skills section in AGENTS.md if missing (#3)", {
  proj_dir <- local_pkg(
    "AGENTS.md" = c(
      "# My Project",
      "",
      "Some content."
    )
  )
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "o",
        repo = "r",
        repo_id = "id",
        issue_types = list()
      ),
      open = FALSE
    )
  )
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("^## Skills", content)))
  expect_true(any(grepl("create GitHub issues", content)))
})

test_that(".use_skill() updates trigger for existing row in AGENTS.md (#3)", {
  proj_dir <- local_pkg(
    "AGENTS.md" = c(
      "## Skills",
      "",
      "| Triggers | Path |",
      "|----------|------|",
      "| old trigger | @.github/skills/create-issue/SKILL.md |"
    )
  )
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "o",
        repo = "r",
        repo_id = "id",
        issue_types = list()
      ),
      open = FALSE
    )
  )
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_false(any(grepl("old trigger", content)))
  expect_true(any(grepl("create GitHub issues", content)))
})

test_that(".use_skill() does not touch AGENTS.md when it does not exist (#3)", {
  proj_dir <- local_pkg()
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "o",
        repo = "r",
        repo_id = "id",
        issue_types = list()
      ),
      open = FALSE
    )
  )
  expect_false(fs::file_exists(fs::path(proj_dir, "AGENTS.md")))
})

test_that(".use_skill() errors when overwrite = FALSE and file exists (#3)", {
  proj_dir <- local_pkg()
  existing_path <- fs::path(proj_dir, ".github/skills/create-issue/SKILL.md")
  fs::dir_create(fs::path_dir(existing_path))
  writeLines("original content", existing_path)
  stbl::expect_pkg_error_classes(
    suppressMessages(
      .use_skill(
        "create-issue",
        data = list(
          owner = "o",
          repo = "r",
          repo_id = "id",
          issue_types = list()
        ),
        overwrite = FALSE,
        open = FALSE
      )
    ),
    "pkgskills",
    "file_exists"
  )
  expect_equal(readLines(existing_path), "original content")
})

test_that(".use_skill() overwrites file when overwrite = TRUE and file exists (#3)", {
  proj_dir <- local_pkg()
  existing_path <- fs::path(proj_dir, ".github/skills/create-issue/SKILL.md")
  fs::dir_create(fs::path_dir(existing_path))
  writeLines("original content", existing_path)
  suppressMessages(
    .use_skill(
      "create-issue",
      data = list(
        owner = "o",
        repo = "r",
        repo_id = "id",
        issue_types = list()
      ),
      overwrite = TRUE,
      open = FALSE
    )
  )
  content <- readLines(existing_path)
  expect_false(identical(content, "original content"))
  expect_true(any(grepl("Create a GitHub issue", content)))
})

test_that(".use_skill() errors on non-scalar skill (#3)", {
  stbl::expect_pkg_error_classes(
    .use_skill(c("a", "b"), data = list(), open = FALSE),
    "stbl",
    "non_scalar"
  )
})

test_that(".use_skill() errors on non-logical use_skills_subdir (#3)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    .use_skill(
      "create-issue",
      data = list(),
      use_skills_subdir = "yes",
      open = FALSE
    ),
    "stbl",
    "incompatible_type"
  )
})

test_that(".use_skill() errors on non-logical overwrite (#3)", {
  local_pkg()
  stbl::expect_pkg_error_classes(
    .use_skill("create-issue", data = list(), overwrite = "yes", open = FALSE),
    "stbl",
    "incompatible_type"
  )
})

test_that(".read_skill_trigger() errors when template file not found (#3)", {
  stbl::expect_pkg_error_classes(
    .read_skill_trigger("/tmp/nonexistent/SKILL.md"),
    "pkgskills",
    "template_not_found"
  )
})

test_that(".read_skill_trigger() errors when front matter is missing (#3)", {
  tmp <- withr::local_tempfile(fileext = ".md")
  writeLines(c("# No front matter here", "Just content."), tmp)
  stbl::expect_pkg_error_classes(
    .read_skill_trigger(tmp),
    "pkgskills",
    "no_front_matter"
  )
})

test_that(".read_skill_trigger() errors when trigger field is absent (#3)", {
  tmp <- withr::local_tempfile(fileext = ".md")
  writeLines(c("---", "name: my-skill", "---", "# Content"), tmp)
  stbl::expect_pkg_error_classes(
    .read_skill_trigger(tmp),
    "pkgskills",
    "no_trigger"
  )
})

test_that(".upsert_agents_skills_row() creates table when ## Skills has no table (#3)", {
  proj_dir <- local_pkg(
    "AGENTS.md" = c("# Project", "", "## Skills", "", "No table here.")
  )
  .upsert_agents_skills_row("my trigger", ".github/skills/test/SKILL.md")
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("\\| Triggers \\| Path \\|", content)))
  expect_true(any(grepl("my trigger", content)))
})

test_that(".upsert_agents_skills_row() appends row after non-terminal table (#3)", {
  proj_dir <- local_pkg(
    "AGENTS.md" = c(
      "## Skills",
      "",
      "| Triggers | Path |",
      "|----------|------|",
      "| existing skill | @.github/skills/other/SKILL.md |",
      "",
      "## Other section"
    )
  )
  .upsert_agents_skills_row("new skill", ".github/skills/new/SKILL.md")
  content <- readLines(fs::path(proj_dir, "AGENTS.md"))
  expect_true(any(grepl("new skill", content)))
  expect_true(any(grepl("existing skill", content)))
})

test_that(".upsert_agents_skills_row() returns NULL invisibly when AGENTS.md absent (#3)", {
  proj_dir <- local_pkg()
  result <- withVisible(
    .upsert_agents_skills_row("my trigger", ".github/skills/test/SKILL.md")
  )
  expect_false(result$visible)
  expect_null(result$value)
})
