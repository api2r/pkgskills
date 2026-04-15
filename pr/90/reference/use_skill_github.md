# Install the github skill into a project

Installs the `github` skill template into the project. The installed
skill teaches AI agents how to use the `gh` CLI and write conventional
commit messages for the package.

## Usage

``` r
use_skill_github(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive()
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

  (`logical(1)`) Whether to overwrite existing file(s). Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

## Value

The path to the installed skill file, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_skill_github()
}
```
