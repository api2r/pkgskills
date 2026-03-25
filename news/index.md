# Changelog

## pkgskills (development version)

- `tdd-workflow` skill now documents
  [`stbl::expect_pkg_error_snapshot()`](https://stbl.api2r.org/reference/expect_pkg_error_snapshot.html)
  with an explicit `package` argument instead of a helper-defined
  version ([\#51](https://github.com/api2r/pkgskills/issues/51)).

- Tests now use
  [`stbl::expect_pkg_error_snapshot()`](https://stbl.api2r.org/reference/expect_pkg_error_snapshot.html)
  directly instead of a locally-defined wrapper; the
  `expect_pkg_error_snapshot()` definition has been removed from
  `tests/testthat/helper-expectations.R`
  ([\#50](https://github.com/api2r/pkgskills/issues/50)).

- [`use_skill_tdd_workflow()`](https://api2r.github.io/pkgskills/reference/use_skill_tdd_workflow.md)
  no longer installs `helper-expectations.R` into the target project;
  [`stbl::expect_pkg_error_snapshot()`](https://stbl.api2r.org/reference/expect_pkg_error_snapshot.html)
  is now used directly
  ([\#52](https://github.com/api2r/pkgskills/issues/52)).

- [`use_skill_r_code()`](https://api2r.github.io/pkgskills/reference/use_skill_r_code.md)
  now installs a minimal `R/aaa-conditions.R` into the project when the
  file does not already exist
  ([\#48](https://github.com/api2r/pkgskills/issues/48)).

- Internal coercion wrappers `.to_string()` and `.to_boolean()` replaced
  with direct
  [`stbl::to_character_scalar()`](https://stbl.api2r.org/reference/stabilize_chr.html)
  and
  [`stbl::to_lgl_scalar()`](https://stbl.api2r.org/reference/stabilize_lgl.html)
  calls; `R/utils-coerce.R` removed
  ([\#46](https://github.com/api2r/pkgskills/issues/46)).

- [`use_github_copilot()`](https://api2r.github.io/pkgskills/reference/use_github_copilot.md)
  now writes workflow files byte-for-byte from the templates, preserving
  `${{ }}` GitHub Actions expressions that were previously corrupted by
  whisker rendering
  ([\#44](https://github.com/api2r/pkgskills/issues/44)).

- [`use_ai()`](https://api2r.github.io/pkgskills/reference/use_ai.md)
  now works when called via
  [`pkgskills::use_ai()`](https://api2r.github.io/pkgskills/reference/use_ai.md)
  without first calling
  [`library(pkgskills)`](https://github.com/api2r/pkgskills)
  ([\#42](https://github.com/api2r/pkgskills/issues/42)).

- [`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)
  now accepts an `overwrite` argument (default `FALSE`) and errors if
  `AGENTS.md` already exists, consistent with other `use_*()` functions
  ([\#36](https://github.com/api2r/pkgskills/issues/36)).

- All `use_*()` functions that accept `overwrite` now default to `FALSE`
  ([\#36](https://github.com/api2r/pkgskills/issues/36)).

- [`vignette("pkgskills")`](https://api2r.github.io/pkgskills/articles/pkgskills.md)
  now provides a complete “Get Started” guide covering terminology,
  [`use_ai()`](https://api2r.github.io/pkgskills/reference/use_ai.md)
  setup, skill descriptions, and issue-writing best practices
  ([\#31](https://github.com/api2r/pkgskills/issues/31)).

- [`use_ai()`](https://api2r.github.io/pkgskills/reference/use_ai.md)
  sets up the full AI agent suite in a single call, installing
  `AGENTS.md`, the GitHub Copilot workflow, and all selected skills
  ([\#28](https://github.com/api2r/pkgskills/issues/28)).

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
