# Compute updated AGENTS.md lines with a skill row upserted

Reads `path` and validates inputs. Replaces the existing row for
`save_as` if found; otherwise delegates to
[`.agents_lines_add_skill_row()`](https://api2r.github.io/pkgskills/reference/dot-agents_lines_add_skill_row.md).

## Usage

``` r
.agents_lines_upsert_skill(path, trigger, save_as, call = caller_env())
```

## Arguments

- path:

  (`character(1)`) Path to `AGENTS.md`.

- trigger:

  (`character(1)`) Trigger phrase for the skill.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character`) Updated lines.
