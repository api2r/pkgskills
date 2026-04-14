# pkgskills (development version)

* `use_github_copilot()` now uses the external, stable `api2r/actions/install@v1` composite workflow instead of the local `install` action (#84).

* `use_ai()` no longer fails when `DESCRIPTION` has no `BugReports` field; it now falls back to git remotes (`upstream` then `origin`) to construct the URL and writes it to `DESCRIPTION` automatically (#82).

* `use_github_copilot_whitelist()` configures the Copilot coding agent firewall allowlist (#79).

* `AGENTS.md` and `tdd-workflow` skill instructions now explicitly explain how to determine the GitHub issue number and warn agents never to guess or invent one (@copilot, #61).
* `use_agent()` template is reconciled with this package's `AGENTS.md` file (#59).
* `tdd-workflow` skill now documents `stbl::expect_pkg_error_snapshot()` with an explicit `package` argument instead of a helper-defined version (#51).
* Tests now use `stbl::expect_pkg_error_snapshot()` directly instead of a locally-defined wrapper; the `expect_pkg_error_snapshot()` definition has been removed from `tests/testthat/helper-expectations.R` (#50).
* `use_skill_tdd_workflow()` no longer installs `helper-expectations.R` into the target project; `stbl::expect_pkg_error_snapshot()` is now used directly (#52).
* `use_skill_r_code()` now installs a minimal `R/aaa-conditions.R` into the project when the file does not already exist (#48).
* Internal coercion wrappers `.to_string()` and `.to_boolean()` replaced with direct `stbl::to_character_scalar()` and `stbl::to_lgl_scalar()` calls; `R/utils-coerce.R` removed (#46).
* `use_github_copilot()` now writes workflow files byte-for-byte from the templates, preserving `${{ }}` GitHub Actions expressions that were previously corrupted by whisker rendering (#44).
* `use_ai()` now works when called via `pkgskills::use_ai()` without first calling `library(pkgskills)` (#42).
* `use_agent()` now accepts an `overwrite` argument (default `FALSE`) and errors if `AGENTS.md` already exists, consistent with other `use_*()` functions (#36).
* All `use_*()` functions that accept `overwrite` now default to `FALSE` (#36).
* `vignette("pkgskills")` now provides a complete "Get Started" guide covering terminology, `use_ai()` setup, skill descriptions, and issue-writing best practices (#31).
* `use_ai()` sets up the full AI agent suite in a single call, installing `AGENTS.md`, the GitHub Copilot workflow, and all selected skills (#28).
* `use_github_copilot()` installs a `copilot-setup-steps.yml` workflow and its companion reusable `install` action into `.github/workflows/` (#25).
* `use_skill_implement_issue()` installs the `implement-issue` skill into the target project (#18).
* `use_skill_github()` installs the `github` skill, providing AI agents with
  `gh` CLI guidance and conventional commit message conventions (#17).
* `use_skill_r_code()` installs the `r-code` skill into the target project (#17).
* `use_skill_search_code()` installs the `search-code` skill into the target project (#20).
* `use_skill_tdd_workflow()` installs the `tdd-workflow` skill and bootstraps
  `tests/testthat/helper-expectations.R` in the target project (#11).
* `use_skill_document()` installs the `document` skill and, if absent, creates a starter `R/aaa-shared_params.R` file from a built-in template (#9).
* `use_skill_create_issue()` installs the `create-issue` skill, fetching
  repository metadata from GitHub and rendering a tailored skill template into
  the project (#3).
* `use_agent()` installs a structured `AGENTS.md` file, populating the
  repository overview from the project's `DESCRIPTION` (#2).

# pkgskills 0.0.0.8000

* Temporary bullet so R CMD check is ok with NEWS.md before first release.
