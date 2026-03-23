# Install the create-issue skill into a project

Fetches repository metadata from GitHub and renders the `create-issue`
skill template into the project. The installed skill teaches AI agents
how to create well-structured GitHub issues for the package.

## Usage

``` r
use_skill_create_issue(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token()
)
```

## Arguments

- target_dir:

  (`character(1)`) Directory where the skill will be installed, relative
  to the project root. Defaults to `".github"`.

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

## Value

The path to the installed skill file, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_skill_create_issue()
}
```
