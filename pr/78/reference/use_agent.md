# Create an AGENTS.md file for your project

Writes a structured `AGENTS.md` file to help AI agents understand your
project. The repository overview is populated from your `DESCRIPTION`
file.

## Usage

``` r
use_agent(
  save_as = "AGENTS.md",
  overwrite = FALSE,
  open = rlang::is_interactive()
)
```

## Arguments

- save_as:

  (`character(1)`) Output file path, relative to the project root.

- overwrite:

  (`logical(1)`) Whether to overwrite an existing file. Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

## Value

The path to the created file, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_agent()
}
```
