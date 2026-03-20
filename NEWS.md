# pkgskills (development version)

* `use_skill_document()` installs the `document` skill and, if absent, creates a starter `R/aaa-shared_params.R` file from a built-in template.
* `use_skill_create_issue()` installs the `create-issue` skill, fetching
  repository metadata from GitHub and rendering a tailored skill template into
  the project (#3).
* `use_agent()` installs a structured `AGENTS.md` file, populating the
  repository overview from the project's `DESCRIPTION` (#2).

# pkgskills 0.0.0.8000

* Temporary bullet so R CMD check is ok with NEWS.md before first release.
