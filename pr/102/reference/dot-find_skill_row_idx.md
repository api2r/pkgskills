# Find the line index of an existing skill row in AGENTS.md

Find the line index of an existing skill row in AGENTS.md

## Usage

``` r
.find_skill_row_idx(agents_lines, save_as)
```

## Arguments

- agents_lines:

  (`character`) Lines of `AGENTS.md`.

- save_as:

  (`character(1)`) Output file path, relative to the project root.

## Value

(`integer(1)`) Index of the first matching line, or
[`integer()`](https://rdrr.io/r/base/integer.html).
