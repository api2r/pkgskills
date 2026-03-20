# Install the tdd-workflow skill into a project

Installs the `tdd-workflow` skill into the project and, if
`tests/testthat/helper-expectations.R` does not already exist, creates
it from the package template.

## Usage

``` r
use_skill_tdd_workflow(
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
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

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `TRUE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

## Value

The path to the installed skill file, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_skill_tdd_workflow()
}
```
