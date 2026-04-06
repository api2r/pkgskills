# Install GitHub Copilot setup workflow into a project

Installs a `copilot-setup-steps.yml` workflow and its companion reusable
`install` action into the project's `.github/workflows/` directory. Also
calls
[`use_github_copilot_whitelist()`](https://pkgskills.api2r.org/reference/use_github_copilot_whitelist.md)
to configure the coding agent firewall allowlist.

## Usage

``` r
use_github_copilot(
  overwrite = FALSE,
  open = rlang::is_interactive(),
  allowlist = c("api.github.com", "api2r.org", "bioconductor.org", "cloud.r-project.org",
    "CRAN.R-project.org", "docs.github.com", "r-lib.org", "rstudio.github.io",
    "tidymodels.org", "tidyverse.org", "wrangle.zone"),
  gh_token = gh::gh_token()
)
```

## Arguments

- overwrite:

  (`logical(1)`) Whether to overwrite existing files. Defaults to
  `FALSE`.

- open:

  (`logical(1)`) Whether to open the file after creation.

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to a curated set of R and GitHub domains.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

## Value

The path to the installed `.github/workflows/copilot-setup-steps.yml`,
invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_github_copilot()
}
```
