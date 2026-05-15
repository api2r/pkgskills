# Insert lines into a character vector after a given index

Insert lines into a character vector after a given index

## Usage

``` r
.lines_insert_after(lines, idx, new_lines)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- idx:

  (`integer(1)`) Position after which `new_lines` will be inserted.

- new_lines:

  (`character`) Lines to insert.

## Value

(`character`) Updated lines with `new_lines` spliced in after `idx`.
