# use_agent() substitutes Package and Title into the template (#2)

    Code
      writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
    Output
      # AGENTS.md
      
      ## Repository overview
      
      **mypkg** — My Test Package
      
      A package for testing.
      
      https://example.com
      
      ### Overall structure
      
      The project follows standard R package conventions with these key directories:
      
      mypkg/
      ├── R/                          # R source code
      │   ├── mypkg-package.R # Auto-generated package docs
      │   └── *.R                     # Function definitions, 1 file ~= 1 exported function
      ├── .github/
      │   ├── ISSUE_TEMPLATE/         # GitHub issue templates
      │   ├── skills/                 # Agent skill definitions
      │   └── workflows/              # CI/CD configurations
      ├── tests/testthat/             # Test suite
      ├── man/                        # Generated documentation
      ├── AGENTS.md                   # Main agent setup file
      ├── DESCRIPTION                 # Package metadata
      ├── NAMESPACE                   # Auto-generated export information
      ├── NEWS.md                     # Changelog
      └── Various config files        # .gitignore, codecov.yml, etc.
      
      ---
      
      ## Standard workflow
      
      For any feature, fix, or refactor:
      
      1. **Update packages**: `pak::pak()`
      2. **Run tests** — confirm passing before changes: `devtools::test(reporter = "check")`. If any fail, stop and ask.
      3. **Plan** — identify affected R files; check if new exports are needed.
      4. **Test first** — write failing test, then implement: `devtools::test(filter = "name", reporter = "check")`.
      5. **Implement** — minimal code to pass tests.
      6. **Refactor** — clean up, keep tests green.
      7. **Document** — document any new or changed exports.
      8. **Verify**: `devtools::check(error_on = "warning")`. Resolve warnings, errors, and NOTEs.
      9. **News** — add a bullet at the top of `NEWS.md` for user-facing changes.
      
      ---
      
      ## General
      
      - R console: use `--quiet --vanilla`.
      - Comments explain *why*, not *what*.

# use_agent() does not insert 'NA' when Description or URL is absent (#2)

    Code
      writeLines(readLines(fs::path(proj_dir, "AGENTS.md")))
    Output
      # AGENTS.md
      
      ## Repository overview
      
      **minpkg** — Minimal Package
      
      ### Overall structure
      
      The project follows standard R package conventions with these key directories:
      
      minpkg/
      ├── R/                          # R source code
      │   ├── minpkg-package.R # Auto-generated package docs
      │   └── *.R                     # Function definitions, 1 file ~= 1 exported function
      ├── .github/
      │   ├── ISSUE_TEMPLATE/         # GitHub issue templates
      │   ├── skills/                 # Agent skill definitions
      │   └── workflows/              # CI/CD configurations
      ├── tests/testthat/             # Test suite
      ├── man/                        # Generated documentation
      ├── AGENTS.md                   # Main agent setup file
      ├── DESCRIPTION                 # Package metadata
      ├── NAMESPACE                   # Auto-generated export information
      ├── NEWS.md                     # Changelog
      └── Various config files        # .gitignore, codecov.yml, etc.
      
      ---
      
      ## Standard workflow
      
      For any feature, fix, or refactor:
      
      1. **Update packages**: `pak::pak()`
      2. **Run tests** — confirm passing before changes: `devtools::test(reporter = "check")`. If any fail, stop and ask.
      3. **Plan** — identify affected R files; check if new exports are needed.
      4. **Test first** — write failing test, then implement: `devtools::test(filter = "name", reporter = "check")`.
      5. **Implement** — minimal code to pass tests.
      6. **Refactor** — clean up, keep tests green.
      7. **Document** — document any new or changed exports.
      8. **Verify**: `devtools::check(error_on = "warning")`. Resolve warnings, errors, and NOTEs.
      9. **News** — add a bullet at the top of `NEWS.md` for user-facing changes.
      
      ---
      
      ## General
      
      - R console: use `--quiet --vanilla`.
      - Comments explain *why*, not *what*.

# use_agent() emits an informational message after writing (#2)

    Code
      use_agent(open = FALSE)
    Message
      'AGENTS.md' created.
      i To tailor it to your project, tell your AI agent this: "Tailor @AGENTS.md to reflect this repository's actual structure. Focus on the **Repository overview** and the **Key files** table."

