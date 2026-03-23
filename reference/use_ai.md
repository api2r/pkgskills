# Set up the full AI agent suite for a project

Calls
[`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)
and
[`use_github_copilot()`](https://api2r.github.io/pkgskills/reference/use_github_copilot.md)
unconditionally, then installs each skill in `skills`. Returns a named
list of all paths invisibly.

## Usage

``` r
use_ai(
  save_agent_as = "AGENTS.md",
  target_skills_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token(),
  skills = c("create-issue", "document", "github", "implement-issue", "r-code",
    "search-code", "tdd-workflow")
)
```

## Arguments

- save_agent_as:

  (`character(1)`) Output path for `AGENTS.md`, relative to the project
  root. Passed to
  [`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)
  as `save_as`.

- target_skills_dir:

  (`character(1)`) Directory where skills will be installed. Passed to
  all `use_skill_*()` functions as `target_dir`.

- use_skills_subdir:

  (`logical(1)`) Whether to place the skill folder under a `skills`
  subdirectory of `target_dir`. Defaults to `TRUE`, producing
  `.github/skills/{skill}/SKILL.md`.

- overwrite:

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

- skills:

  (`character`) Which skills to install. Defaults to all known skills.
  Pass a subset to install only specific skills, or `character(0)` for
  none.

## Value

A named list of paths returned by each wrapped function, invisibly.
Names match the function name that produced each path (e.g.
`list(use_agent = ..., use_github_copilot = ..., use_skill_create_issue = ..., ...)`).
Skills not selected are omitted.

## Examples

``` r
if (FALSE) { # interactive()

  use_ai()
}
```
