# Add a skill row to an existing \## Skills section

Inserts a new table if none exists in the section; otherwise appends the
row to the existing table.

## Usage

``` r
.agents_lines_add_to_section(lines, section_idx, new_row)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- section_idx:

  (`integer(1)`) Index of the `## Skills` heading line.

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://api2r.github.io/pkgskills/reference/dot-make_skill_row.md).

## Value

(`character`) Updated lines.
