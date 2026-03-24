test_that("use_ai() returns invisibly (#28, #42)", {
  local_pkg()
  local_gh_mock()
  result <- withVisible(suppressMessages(use_ai(open = FALSE)))
  expect_false(result$visible)
  expect_type(result$value, "list")
})

test_that("use_ai() returns a named list with all function names (#28, #42)", {
  local_pkg()
  local_gh_mock()
  result <- suppressMessages(use_ai(open = FALSE))
  expect_named(
    result,
    c(
      "use_agent",
      "use_github_copilot",
      "use_skill_create_issue",
      "use_skill_document",
      "use_skill_github",
      "use_skill_implement_issue",
      "use_skill_r_code",
      "use_skill_search_code",
      "use_skill_tdd_workflow"
    )
  )
})

test_that("use_ai() installs only selected skills (#28, #42)", {
  local_pkg()
  result <- suppressMessages(use_ai(
    skills = c("r-code", "github"),
    open = FALSE
  ))
  expect_named(
    result,
    c(
      "use_agent",
      "use_github_copilot",
      "use_skill_r_code",
      "use_skill_github"
    )
  )
})

test_that("use_ai() errors on invalid skill name (#28, #42)", {
  local_pkg()
  expect_error(
    use_ai(skills = "invalid-skill"),
    class = "rlang_error"
  )
})

test_that("use_ai() creates AGENTS.md and copilot workflow (#28, #42)", {
  proj_dir <- local_pkg()
  local_gh_mock()
  suppressMessages(use_ai(open = FALSE))
  expect_true(fs::file_exists(fs::path(proj_dir, "AGENTS.md")))
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    ".github/workflows/copilot-setup-steps.yml"
  )))
})

test_that("use_ai() creates selected skill files (#28, #42)", {
  proj_dir <- local_pkg()
  suppressMessages(use_ai(skills = c("r-code", "tdd-workflow"), open = FALSE))
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    ".github/skills/r-code/SKILL.md"
  )))
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    ".github/skills/tdd-workflow/SKILL.md"
  )))
  expect_false(fs::file_exists(fs::path(
    proj_dir,
    ".github/skills/github/SKILL.md"
  )))
})

test_that("use_ai() respects save_agent_as (#28, #42)", {
  proj_dir <- local_pkg()
  local_gh_mock()
  result <- suppressMessages(use_ai(
    save_agent_as = "docs/AGENTS.md",
    skills = character(0),
    open = FALSE
  ))
  expect_true(fs::file_exists(fs::path(proj_dir, "docs/AGENTS.md")))
  expect_equal(
    fs::path_real(result$use_agent),
    fs::path_real(fs::path(proj_dir, "docs/AGENTS.md"))
  )
})

test_that("use_ai() respects target_skills_dir (#28, #42)", {
  proj_dir <- local_pkg()
  suppressMessages(use_ai(
    target_skills_dir = "agent-config",
    skills = "r-code",
    open = FALSE
  ))
  expect_true(fs::file_exists(fs::path(
    proj_dir,
    "agent-config/skills/r-code/SKILL.md"
  )))
})

test_that("pkgskills::use_ai() works without library(pkgskills) (#42)", {
  skip_if_not_installed("callr")
  result <- callr::r(function() {
    # pkgskills namespace is available via :: but library(pkgskills) is not called,
    # simulating the scenario described in #42
    proj_dir <- withr::local_tempdir()
    writeLines(
      c(
        "Package: mypkg",
        "Title: My Test Package",
        "Description: A package for testing.",
        "Version: 0.1.0",
        "URL: https://example.com",
        "BugReports: https://github.com/myorg/mypkg/issues"
      ),
      file.path(proj_dir, "DESCRIPTION")
    )
    usethis::local_project(proj_dir, quiet = TRUE)
    suppressMessages(
      pkgskills::use_ai(skills = "r-code", open = FALSE)
    )
  })
  expect_type(result, "list")
  expect_named(result, c("use_agent", "use_github_copilot", "use_skill_r_code"))
})

test_that("use_ai() passes gh_token to use_skill_create_issue() (#28, #42)", {
  local_pkg()
  local_mocked_bindings(
    use_skill_create_issue = function(
      target_dir,
      use_skills_subdir,
      overwrite,
      open,
      gh_token
    ) {
      expect_equal(gh_token, "test-token")
      invisible(usethis::proj_path(".github/skills/create-issue/SKILL.md"))
    }
  )
  suppressMessages(use_ai(
    skills = "create-issue",
    open = FALSE,
    gh_token = "test-token"
  ))
})
