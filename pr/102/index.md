# pkgskills

A collection of curated, opinionated skills and agent instructions to
improve agentic coding of R packages.

## Installation

You can install pkgskills from
[GitHub](https://github.com/api2r/pkgskills) with:

``` r
# install.packages("pak")
pak::pak("api2r/pkgskills")
```

## Usage

pkgskills installs `AGENTS.md` and curated skill files into an R package
project, giving AI coding agents the project-specific context they need
to contribute effectively. The quickest way to get started is a single
call to [`use_ai()`](https://pkgskills.api2r.org/reference/use_ai.md):

``` r
pkgskills::use_ai()
```

This installs:

- **`AGENTS.md`** — a top-level context file describing your repository
  layout, standard workflow, and available skills.
- **A GitHub Copilot workflow** — so Copilot Coding Agent can work on
  your repository.
- **Seven skills** in `.github/skills/` — opinionated guidance for
  creating issues, implementing issues, writing R code, test-driven
  development, documenting functions, code search, and GitHub CLI usage.

See
[`vignette("pkgskills")`](https://pkgskills.api2r.org/articles/pkgskills.md)
for a full walkthrough.

## Code of Conduct

Please note that the pkgskills project is released with a [Contributor
Code of
Conduct](https://api2r.github.io/pkgskills/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
