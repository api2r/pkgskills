# Build the project-relative save path for a skill file

Build the project-relative save path for a skill file

## Usage

``` r
.path_skill_save_as(
  skill,
  target_dir = ".github",
  use_skills_subdir = TRUE,
  call = caller_env()
)
```

## Arguments

- skill:

  (`character(1)`) Skill name. A folder name under
  `inst/templates/skills/`, e.g. `"create-issue"`. Determines the
  template path and the install subdirectory.

- target_dir:

  (`character(1)`) Directory where the skill will be installed, relative
  to the project root. Defaults to `".github"`.

- use_skills_subdir:

  (`logical(1)`) Whether to place the skill folder under a `skills`
  subdirectory of `target_dir`. Defaults to `TRUE`, producing
  `.github/skills/{skill}/SKILL.md`.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) Relative path to the `SKILL.md` file within the
project.
