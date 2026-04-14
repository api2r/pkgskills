# Read the trigger field from a skill template's YAML front matter

Read the trigger field from a skill template's YAML front matter

## Usage

``` r
.read_skill_trigger(path, call = caller_env())
```

## Arguments

- path:

  (`character(1)`) Path to the skill template file.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) The trigger phrase.
