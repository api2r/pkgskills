# Build a BugReports URL from git remotes and add it to DESCRIPTION

Looks up remotes via
[`gert::git_remote_list()`](https://docs.ropensci.org/gert/reference/git_remote.html),
prefers `upstream` over `origin`, and requires the URL to be on
github.com. If a suitable remote is found, the constructed URL is
written to DESCRIPTION and returned so that processing can continue
normally.

## Usage

``` r
.bug_reports_from_remote(call = caller_env())
```

## Arguments

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) The BugReports URL.
