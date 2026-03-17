# Create an AGENTS.md file for your project

Writes a structured `AGENTS.md` file to help AI agents understand your
project. The repository overview is populated from your `DESCRIPTION`
file.

## Usage

``` r
use_agent(save_as = "AGENTS.md", open = rlang::is_interactive())
```

## Arguments

- save_as:

  (`character(1)`) Output file path, relative to the project root.

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
