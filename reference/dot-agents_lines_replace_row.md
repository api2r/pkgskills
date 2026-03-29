# Replace an existing skill row in AGENTS.md lines

Replace an existing skill row in AGENTS.md lines

## Usage

``` r
.agents_lines_replace_row(lines, row_idx, new_row)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- row_idx:

  (`integer(1)`) Index of the row to replace.

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://pkgskills.api2r.org/reference/dot-make_skill_row.md).

## Value

(`character`) Updated lines.
