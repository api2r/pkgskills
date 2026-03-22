# Changelog

## pkgskills (development version)

- [`use_github_copilot()`](https://api2r.github.io/pkgskills/reference/use_github_copilot.md)
  installs a `copilot-setup-steps.yml` workflow and its companion
  reusable `install` action into `.github/workflows/`
  ([\#25](https://github.com/api2r/pkgskills/issues/25)).
- [`use_skill_implement_issue()`](https://api2r.github.io/pkgskills/reference/use_skill_implement_issue.md)
  installs the `implement-issue` skill into the target project
  ([\#18](https://github.com/api2r/pkgskills/issues/18)).
- [`use_skill_github()`](https://api2r.github.io/pkgskills/reference/use_skill_github.md)
  installs the `github` skill, providing AI agents with `gh` CLI
  guidance and conventional commit message conventions
  ([\#17](https://github.com/api2r/pkgskills/issues/17)).
- [`use_skill_r_code()`](https://api2r.github.io/pkgskills/reference/use_skill_r_code.md)
  installs the `r-code` skill into the target project
  ([\#17](https://github.com/api2r/pkgskills/issues/17)).
- [`use_skill_search_code()`](https://api2r.github.io/pkgskills/reference/use_skill_search_code.md)
  installs the `search-code` skill into the target project
  ([\#20](https://github.com/api2r/pkgskills/issues/20)).
- [`use_skill_tdd_workflow()`](https://api2r.github.io/pkgskills/reference/use_skill_tdd_workflow.md)
  installs the `tdd-workflow` skill and bootstraps
  `tests/testthat/helper-expectations.R` in the target project
  ([\#11](https://github.com/api2r/pkgskills/issues/11)).
- [`use_skill_document()`](https://api2r.github.io/pkgskills/reference/use_skill_document.md)
  installs the `document` skill and, if absent, creates a starter
  `R/aaa-shared_params.R` file from a built-in template
  ([\#9](https://github.com/api2r/pkgskills/issues/9)).
- [`use_skill_create_issue()`](https://api2r.github.io/pkgskills/reference/use_skill_create_issue.md)
  installs the `create-issue` skill, fetching repository metadata from
  GitHub and rendering a tailored skill template into the project
  ([\#3](https://github.com/api2r/pkgskills/issues/3)).
- [`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)
  installs a structured `AGENTS.md` file, populating the repository
  overview from the project’s `DESCRIPTION`
  ([\#2](https://github.com/api2r/pkgskills/issues/2)).

## pkgskills 0.0.0.8000

- Temporary bullet so R CMD check is ok with NEWS.md before first
  release.
