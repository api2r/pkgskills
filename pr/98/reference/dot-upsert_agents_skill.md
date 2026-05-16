# Upsert a skill row in the \## Skills table of AGENTS.md

Upsert a skill row in the \## Skills table of AGENTS.md

## Usage

``` r
.upsert_agents_skill(trigger, save_as, call = caller_env())
```

## Arguments

- trigger:

  (`character(1)`) Trigger phrase for the skill.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- call:

  (`environment`) The caller environment for error messages.

## Value

The path to `AGENTS.md`, invisibly, or `NULL` invisibly if `AGENTS.md`
does not exist.
