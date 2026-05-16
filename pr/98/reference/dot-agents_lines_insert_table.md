# Insert a skills table after the \## Skills heading in AGENTS.md lines

Insert a skills table after the \## Skills heading in AGENTS.md lines

## Usage

``` r
.agents_lines_insert_table(lines, section_idx, new_row)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- section_idx:

  (`integer(1)`) Index of the `## Skills` heading line.

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://pkgskills.api2r.org/reference/dot-make_skill_row.md).

## Value

(`character`) Updated lines.
