# Fetch the GraphQL node ID for a GitHub repository

Fetch the GraphQL node ID for a GitHub repository

## Usage

``` r
.fetch_repo_id(owner, repo, gh_token)
```

## Arguments

- owner:

  (`character(1)`) GitHub repository owner (user or organization).

- repo:

  (`character(1)`) GitHub repository name.

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

## Value

(`character(1)`) The repository's GraphQL node ID.
