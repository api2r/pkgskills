# Upsert a template skill row in the \## Skills table of AGENTS.md

Upsert a template skill row in the \## Skills table of AGENTS.md

## Usage

``` r
.upsert_agents_skill_from_template(
  skill_path_relative,
  save_as,
  call = caller_env()
)
```

## Arguments

- skill_path_relative:

  (`character(1)`) The relative path to the `SKILL.md` file, relative to
  the template dir.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- call:

  (`environment`) The caller environment for error messages.

## Value

The path to `AGENTS.md`, invisibly, or `NULL` invisibly if `AGENTS.md`
does not exist.
