# Wrapper around [`usethis::use_template()`](https://usethis.r-lib.org/reference/use_template.html)

Wrapper around
[`usethis::use_template()`](https://usethis.r-lib.org/reference/use_template.html)

## Usage

``` r
.use_template(template, save_as, data, open, call = caller_env())
```

## Arguments

- template:

  (`character(1)`) Template name within `inst/templates/`.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- data:

  (`list`) Named list of whisker template variables for rendering.

- open:

  (`logical(1)`) Whether to open the file after creation.

- call:

  (`environment`) The caller environment for error messages.

## Value

Called for side effects.
