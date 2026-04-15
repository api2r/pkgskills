# Shared parameters

These parameters are used in multiple functions. They are defined here
to make them easier to import and to find.

## Arguments

- agents_lines:

  (`character`) Lines of `AGENTS.md`.

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to
  [`default_allowlist()`](https://pkgskills.api2r.org/reference/default_allowlist.md),
  a curated set of R and GitHub domains.

- call:

  (`environment`) The caller environment for error messages.

- data:

  (`list`) Named list of whisker template variables for rendering.

- fields:

  (`character`) Field name(s) to read from `DESCRIPTION`.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://pkgskills.api2r.org/reference/dot-make_skill_row.md).

- open:

  (`logical(1)`) Whether to open the file after creation.

- overwrite:

  (`logical(1)`) Whether to overwrite existing file(s). Defaults to
  `FALSE`.

- owner:

  (`character(1)`) GitHub repository owner (user or organization).

- repo:

  (`character(1)`) GitHub repository name.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- skill:

  (`character(1)`) Skill name. A folder name under
  `inst/templates/skills/`, e.g. `"create-issue"`. Determines the
  template path and the install subdirectory.

- target_dir:

  (`character(1)`) Directory where the skill will be installed, relative
  to the project root. Defaults to `".github"`.

- trigger:

  (`character(1)`) Trigger phrase for the skill.

- use_skills_subdir:

  (`logical(1)`) Whether to place the skill folder under a `skills`
  subdirectory of `target_dir`. Defaults to `TRUE`, producing
  `.github/skills/{skill}/SKILL.md`.

- x_arg:

  (`character(1)`) Argument name for `x`, used in error messages.
