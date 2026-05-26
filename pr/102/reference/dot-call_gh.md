# Call the GitHub API

Thin wrapper around [`gh::gh()`](https://gh.r-lib.org/reference/gh.html)
to facilitate mocking in tests.

## Usage

``` r
.call_gh(...)
```

## Arguments

- ...:

  Arguments passed to
  [`gh::gh()`](https://gh.r-lib.org/reference/gh.html).

## Value

The API response.
