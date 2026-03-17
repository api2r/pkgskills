# Check whether a path is writable

Check whether a path is writable

## Usage

``` r
.check_path_writable(path, overwrite, call = caller_env())
```

## Arguments

- path:

  (`character(1)`) Absolute path to the file.

- overwrite:

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `TRUE`.

- call:

  (`environment`) The caller environment for error messages.

## Value

`NULL`, invisibly. In part called for side effects: Deletes the file if
it exists and `overwrite = TRUE`. Errors if the file exists and
`overwrite = FALSE`.
