# Inform the user of the Copilot allowlist URL and entries

Inform the user of the Copilot allowlist URL and entries

## Usage

``` r
.inform_copilot_allowlist(owner, repo, allowlist)
```

## Arguments

- owner:

  (`character(1)`) GitHub repository owner (user or organization).

- repo:

  (`character(1)`) GitHub repository name.

- allowlist:

  (`character`) Hostnames to add to the GitHub Copilot coding agent
  firewall allowlist. Defaults to a curated set of R and GitHub domains.

## Value

`NULL`, invisibly.
