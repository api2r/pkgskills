# Add a new skill row to AGENTS.md lines

Appends a new `## Skills` section if none exists; otherwise delegates to
[`.agents_lines_add_to_section()`](https://api2r.github.io/pkgskills/reference/dot-agents_lines_add_to_section.md).

## Usage

``` r
.agents_lines_add_skill_row(lines, new_row)
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
