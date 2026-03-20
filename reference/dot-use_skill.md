# Install a skill into a project

Install a skill into a project

## Usage

``` r
.use_skill(
  skill,
  data = list(),
  target_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = TRUE,
  open = rlang::is_interactive(),
  call = caller_env()
)
```

## Arguments

- skill:

  (`character(1)`) Skill name. A folder name under
  `inst/templates/skills/`, e.g. `"create-issue"`. Determines the
  template path and the install subdirectory.

- data:

  (`list`) Named list of whisker template variables for rendering.

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

- call:

  (`environment`) The caller environment for error messages.

## Value

The path to the installed skill file, invisibly.
