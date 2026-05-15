# Extract YAML front matter lines from a character vector

Extract YAML front matter lines from a character vector

## Usage

``` r
.parse_yaml_front_matter(lines, path, call = caller_env())
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- path:

  (`character(1)`) File path, used only in error messages.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character`) Lines between the opening and closing `---` delimiters.
