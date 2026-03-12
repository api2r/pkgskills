# AGENTS.md

## Repository overview

**pkgskills** — AI Skills for R Package Development

A collection of curated, opinionated skills and agent instructions to improve agentic coding of R packages.

https://github.com/api2r/pkgskills, https://api2r.github.io/pkgskills/

### Key files

| Path | Purpose |
|------|---------|
| `R/` | Exported functions & internal helpers |
| `R/pkgskills-package.R` | Auto-generated package docs; do not edit |
| `R/aaa-shared.R` | Shared `@inheritParams` definitions |
| `R/aaa-conditions.R` | Abort helper & condition class helpers |
| `R/utils.R` | Shared internal helpers |
| `tests/testthat/` | Test suite; mirrors `R/` structure |
| `man/` | Generated docs; do not edit |
| `.github/skills/` | Agent skill files |
| `DESCRIPTION` | Package metadata & dependencies |
| `NAMESPACE` | Auto-generated; do not edit |

---

## Standard workflow

For any feature, fix, or refactor:

1. **Update packages**: `pak::pak()`
2. **Run tests** — confirm passing before changes: `devtools::test(reporter = "check")`. If any fail, stop and ask.
3. **Plan** — identify affected R files; check if new exports are needed (→ r-code skill).
4. **Test first** — write failing test, then implement (→ tdd-workflow skill): `devtools::test(filter = "name", reporter = "check")`.
5. **Implement** — minimal code to pass tests.
6. **Refactor** — clean up, keep tests green.
7. **Document** — use the document skill for new/changed exports.
8. **Verify**:
   ```r
   devtools::test(reporter = "check")
   covr_res <- devtools:::test_coverage_active_file("R/file_name.R")
   which(purrr::map_int(covr_res, "value") == 0)
   ```
   Run `air format .`, then once before wrapping up: `devtools::check(error_on = "warning")`. Resolve warnings, errors, and NOTEs.
9. **News** — add bullet at top of `NEWS.md` (under dev heading):
   - User-facing changes only. 1 line, end with `.`
   - Present tense, positive framing, function names (backticks + `()`) near start: `` * `fn()` now accepts ... `` not `* Fixed ...`
   - Issue/contributor before final period: `` * `fn()` now accepts ... (@user, #N). ``
   - Get username: `gh api user --jq .login`

---

## Skills

Load skills from @.github/skills when the user triggers them.

| Triggers | Path |
|----------|------|
| create GitHub issues | @.github/skills/create-issue/SKILL.md |
| implement issue / work on #NNN | @.github/skills/implement-issue/SKILL.md |
| search / rewrite code | @.github/skills/search-code/SKILL.md |
| writing R functions / API design / error handling | @.github/skills/r-code/SKILL.md |
| writing or reviewing tests | @.github/skills/tdd-workflow/SKILL.md |
| document functions | @.github/skills/document/SKILL.md |

---

## General

- R console: use `--quiet --vanilla`.
- Always run `air format .` after generating R code.
- Comments explain *why*, not *what*.
- When writing or reviewing code, load relevant skills (usually `r-code`, `tdd-workflow`, `document`).
