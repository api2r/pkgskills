# Update the full AI agent suite for a project

Thin wrapper around
[`use_ai()`](https://pkgskills.api2r.org/reference/use_ai.md) with
`overwrite = TRUE` by default.

## Usage

``` r
update_ai(
  save_agent_as = "AGENTS.md",
  target_skills_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token(),
  allowlist = default_allowlist(),
  skills = c("create-issue", "document", "github", "implement-issue", "r-code",
    "search-code", "tdd-workflow")
)
```

## Arguments

- save_agent_as:

  (`character(1)`) Output path for `AGENTS.md`, relative to the project
  root. Passed to
  [`use_agent()`](https://pkgskills.api2r.org/reference/use_agent.md) as
  `save_as`.

- target_skills_dir:

  (`character(1)`) Directory where skills will be installed. Passed to
  all `use_skill_*()` functions as `target_dir`.

- use_skills_subdir:

  (`logical(1)`) Whether to place the skill folder under a `skills`
  subdirectory of `target_dir`. Defaults to `TRUE`, producing
  `.github/skills/{skill}/SKILL.md`.

- overwrite:

  (`logical(1)`) Whether to overwrite existing file(s). Defaults to
  `TRUE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to
  [`default_allowlist()`](https://pkgskills.api2r.org/reference/default_allowlist.md),
  a curated set of R and GitHub domains.

- skills:

  (`character`) Which skills to install. Defaults to all known skills.
  Pass a subset to install only specific skills, or `character(0)` for
  none.

## Value

A named list of paths returned by
[`use_ai()`](https://pkgskills.api2r.org/reference/use_ai.md),
invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  update_ai()
}
```
