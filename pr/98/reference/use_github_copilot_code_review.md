# Install GitHub Copilot code review instructions into a project

Installs `copilot-instructions.md` into the project's `.github/`
directory. The default instructions tell Copilot code review to skip
`.Rd` files in `man/`.

## Usage

``` r
use_github_copilot_code_review(
  overwrite = FALSE,
  open = rlang::is_interactive()
)
```

## Arguments

- overwrite:

  (`logical(1)`) Whether to overwrite existing file(s). Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

## Value

The path to the installed `.github/copilot-instructions.md`, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_github_copilot_code_review()
}
```
