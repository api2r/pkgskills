# Fetch issue types defined for a GitHub repository

Fetch issue types defined for a GitHub repository

## Usage

``` r
.fetch_repo_issue_types(owner, repo, gh_token)
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

(`list`) Issue type nodes, each with `id`, `name`, and `description`
fields.
