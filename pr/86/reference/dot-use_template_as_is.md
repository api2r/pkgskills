# Write a template verbatim to a project file

Write a template verbatim to a project file

## Usage

``` r
.use_template_as_is(
  template,
  save_as,
  overwrite = FALSE,
  open = FALSE,
  call = caller_env()
)
```

## Arguments

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- overwrite:

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

- call:

  (`environment`) The caller environment for error messages.

## Value

Called for side effects.
