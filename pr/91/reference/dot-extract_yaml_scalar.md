# Extract a scalar value from YAML front matter lines

Extract a scalar value from YAML front matter lines

## Usage

``` r
.extract_yaml_scalar(front_matter, field, path, call = caller_env())
```

## Arguments

- front_matter:

  (`character`) Lines of YAML front matter.

- field:

  (`character(1)`) Field name to extract.

- path:

  (`character(1)`) File path, used only in error messages.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) The trimmed value for `field`.
