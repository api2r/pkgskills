# Build and validate a project-relative output path

Build and validate a project-relative output path

## Usage

``` r
.path_proj_save_as(save_as, overwrite, call = caller_env())
```

## Arguments

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- overwrite:

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `FALSE`.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) Absolute path to `save_as` within the active project.
