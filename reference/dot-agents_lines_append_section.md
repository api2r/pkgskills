# Append a new \## Skills section to AGENTS.md lines

Append a new \## Skills section to AGENTS.md lines

## Usage

``` r
.agents_lines_append_section(lines, new_row)
```

## Arguments

- lines:

  (`character`) Lines of a file, as returned by
  [`readLines()`](https://rdrr.io/r/base/readLines.html).

- new_row:

  (`character(1)`) A pre-built skill row string, as produced by
  [`.make_skill_row()`](https://api2r.github.io/pkgskills/reference/dot-make_skill_row.md).

## Value

(`character`) Updated lines.
