# Find the index of the first line matching a pattern

Find the index of the first line matching a pattern

## Usage

``` r
.find_pattern_idx(lines, pattern)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- pattern:

  (`character(1)`) A regex pattern or
  [`stringr::fixed()`](https://stringr.tidyverse.org/reference/modifiers.html)
  string to match against each line.

## Value

(`integer(1)`) Index of the first matching line, or `integer(0)` if no
line matches.
