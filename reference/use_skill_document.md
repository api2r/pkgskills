# Install the document skill into a project

Installs the `document` skill template into the project and, if
`R/aaa-shared_params.R` does not already exist, creates a starter
version from a built-in template.

## Usage

``` r
use_skill_document(
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

  use_skill_document()
}
```
