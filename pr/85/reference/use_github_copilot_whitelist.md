# Update the GitHub Copilot coding agent firewall allowlist

Adds the given hostnames to the Copilot coding agent firewall allowlist
for the current repository. If the GitHub token lacks the required
permissions, the user is informed of the settings URL and the list of
hostnames so they can add them manually. For details, see the [Copilot
firewall
documentation](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/customize-the-agent-firewall#allowlisting-additional-hosts-in-the-agents-firewall).

## Usage

``` r
use_github_copilot_whitelist(
  allowlist = c("api.github.com", "api2r.org", "bioconductor.org", "cloud.r-project.org",
    "CRAN.R-project.org", "docs.github.com", "r-lib.org", "rstudio.github.io",
    "tidymodels.org", "tidyverse.org", "wrangle.zone"),
  gh_token = gh::gh_token()
)
```

## Arguments

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to a curated set of R and GitHub domains.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

## Value

`NULL`, invisibly.

## Examples

``` r
if (FALSE) { # interactive()

  use_github_copilot_whitelist()
}
```
