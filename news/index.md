# Changelog

## pkgskills (development version)

- [`use_skill_document()`](https://api2r.github.io/pkgskills/reference/use_skill_document.md)
  installs the `document` skill and, if absent, creates a starter
  `R/aaa-shared_params.R` file from a built-in template
  ([\#9](https://github.com/api2r/pkgskills/issues/9)).
- [`use_skill_create_issue()`](https://api2r.github.io/pkgskills/reference/use_skill_create_issue.md)
  installs the `create-issue` skill, fetching repository metadata from
  GitHub and rendering a tailored skill template into the project
  ([\#3](https://github.com/api2r/pkgskills/issues/3)).
- [`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)
  installs a structured `AGENTS.md` file, populating the repository
  overview from the project’s `DESCRIPTION`
  ([\#2](https://github.com/api2r/pkgskills/issues/2)).

## pkgskills 0.0.0.8000

- Temporary bullet so R CMD check is ok with NEWS.md before first
  release.
