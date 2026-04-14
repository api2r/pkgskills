# Find the index of the last markdown table row after a given position

Returns the last index of the first contiguous block of `|`-starting
lines found after `from`.

## Usage

``` r
.find_table_last_row_idx(lines, from)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- from:

  (`integer(1)`) Starting position; only lines after `from` are
  considered.

## Value

(`integer(1)`) Index of the last table row, or `integer(0)` if none was
found.
