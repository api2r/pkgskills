# Install GitHub Copilot setup workflow into a project

Installs a `copilot-setup-steps.yml` workflow and its companion reusable
`install` action into the project's `.github/workflows/` directory.

## Usage

``` r
use_github_copilot(overwrite = FALSE, open = rlang::is_interactive())
```

## Arguments

- overwrite:

  (`logical(1)`) Whether to overwrite existing files. Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

## Value

The path to the installed `.github/workflows/copilot-setup-steps.yml`,
invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_github_copilot()
}
```
