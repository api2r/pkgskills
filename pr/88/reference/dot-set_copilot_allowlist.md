# Call the GitHub API to set the Copilot allowlist

Call the GitHub API to set the Copilot allowlist

## Usage

``` r
.set_copilot_allowlist(owner, repo, allowlist, gh_token)
```

## Arguments

- owner:

  (`character(1)`) GitHub repository owner (user or organization).

- repo:

  (`character(1)`) GitHub repository name.

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to a curated set of R and GitHub domains.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

## Value

The API response.
