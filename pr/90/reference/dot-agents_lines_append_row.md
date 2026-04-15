# Append a skill row after the last table row in AGENTS.md lines

Append a skill row after the last table row in AGENTS.md lines

## Usage

``` r
.agents_lines_append_row(lines, last_row_idx, new_row)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- last_row_idx:

  (`integer(1)`) Index of the current last table row.

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://pkgskills.api2r.org/reference/dot-make_skill_row.md).

## Value

(`character`) Updated lines.
