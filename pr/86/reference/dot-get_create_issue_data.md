# Collect template data for the create-issue skill

Collect template data for the create-issue skill

## Usage

``` r
.get_create_issue_data(gh_token, call = caller_env())
```

## Arguments

- gh_token:

  (`character(1)`) A GitHub personal access token. Defaults to
  [`gh::gh_token()`](https://gh.r-lib.org/reference/gh_token.html).

- call:

  (`environment`) The caller environment for error messages.

## Value

(`list`) Named list of whisker template variables.
