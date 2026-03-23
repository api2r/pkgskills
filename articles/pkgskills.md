# Using agentic AI for R package development

## Introduction

AI coding agents can be remarkably effective contributors to R package
development, but only when they have the right context. Without
project-specific guidance, even powerful models tend to produce code
that is syntactically correct but stylistically inconsistent, ignoring
your package’s conventions, testing patterns, and design philosophy.

pkgskills addresses this drawback by installing structured markdown
files into your project: an `AGENTS.md` and a set of skills. These files
encode the opinionated decisions that make R packages consistent and
maintainable.

Before walking through how to use the package, it will help to clarify
four terms that come up throughout this article:

- **Model:** the underlying AI (e.g., Claude Sonnet 4.6). A large
  language model (LLM) is general-purpose; on its own it has broad
  knowledge but no awareness of your specific project, conventions, or
  toolchain.
- **Agent:** a model plus a scaffold that gives it tools (file access,
  shell execution, web search, etc.) and context. Different agents can
  be powered by the same model but behave very differently depending on
  what context and tools they are given. For example, as of this writing
  both Posit Assistant (in RStudio) and GitHub Copilot Coding Agent can
  use Claude Sonnet 4.6 as their underlying model, yet they behave quite
  differently: Posit Assistant is interactive and conversational, while
  Copilot Coding Agent works autonomously in the background on a GitHub
  issue. Both of these agents were used to develop pkgskills.
- **Tool:** a capability that the agent scaffold exposes to the model,
  such as reading or writing files, executing shell commands, or
  searching the web. Tools are what distinguish an agent from a simple
  chat interface; they allow the model to take actions in your project
  rather than just generating text.
- **Skill:** a structured markdown file that gives an agent
  project-specific, opinionated guidance for a particular task. Skills
  bridge the gap between a general-purpose model and the specific
  conventions of your project.

This framing explains why pkgskills exists: the same underlying model
can produce very different results depending on the context it is given.
pkgskills is the delivery mechanism for that context in R package
development.

## `use_ai()`: one call to set everything up

The quickest way to get started is a single call to
[`use_ai()`](https://api2r.github.io/pkgskills/reference/use_ai.md):

``` r
pkgskills::use_ai()
```

This call installs three things:

1.  **`AGENTS.md`** (via
    [`use_agent()`](https://api2r.github.io/pkgskills/reference/use_agent.md)):
    the top-level context file that every agent reads. It describes the
    repository layout, standard workflow, and where to find skills.
2.  **A GitHub Copilot workflow file** (via
    [`use_github_copilot()`](https://api2r.github.io/pkgskills/reference/use_github_copilot.md)):
    a `copilot-setup-steps.yml` workflow and its companion reusable
    `install` action, so Copilot Coding Agent can work on your
    repository.
3.  **Seven skills** installed to `.github/skills/` by default:
    `create-issue`, `document`, `github`, `implement-issue`, `r-code`,
    `search-code`, and `tdd-workflow`.

The full signature is:

``` r
pkgskills::use_ai(
  save_agent_as = "AGENTS.md",
  target_skills_dir = ".github",
  use_skills_subdir = TRUE,
  overwrite = FALSE,
  open = rlang::is_interactive(),
  gh_token = gh::gh_token(),
  skills = c(
    "create-issue", "document", "github", "implement-issue",
    "r-code", "search-code", "tdd-workflow"
  )
)
```

Key parameters:

- `skills`: subset the skills that get installed.
- `overwrite`: whether to overwrite existing files (default `FALSE`).
- `open`: whether to open `AGENTS.md` for editing after installation.

## How skills work

Skills are markdown files that an agent loads on demand when a trigger
phrase appears in the conversation. Each skill provides opinionated,
project-specific guidance beyond what a general-purpose agent already
knows.

Each installed skill is registered in the `## Skills` table in
`AGENTS.md` so every agent knows which skills exist and when to load
them, even if that agent doesn’t normally look in the location where
your skills are saved.

The opinions encoded in these skills are not arbitrary. They reflect the
conventions described in [R Packages (2e)](https://r-pkgs.org/) for
package structure and workflow, the [Tidyverse style
guide](https://style.tidyverse.org/) for code formatting and naming, and
[Tidy design principles](https://design.tidyverse.org/) (and the
opinions and patterns of the writers of this package) for API design.

By embedding these references into skills, pkgskills helps to ensure
that agents produce functional code consistent with the broader R
package ecosystem.

## The skills

pkgskills ships seven skills:

- **`create-issue`**: creates well-structured GitHub issues via the `gh`
  CLI and GraphQL API; enforces conventional-commit titles and a
  standardized body format.
- **`implement-issue`**: end-to-end workflow for implementing a GitHub
  issue: fetch the issue, plan, write tests first, implement, document,
  run checks, and open a pull request.
- **`r-code`**: opinionated guidance on R function design, error
  handling, and code patterns for package development. Draws on [Tidy
  design principles](https://design.tidyverse.org/) for API design
  decisions and the [Tidyverse style
  guide](https://style.tidyverse.org/) for code style.
- **`tdd-workflow`**: test-driven development: write a failing test,
  implement to pass, refactor.
- **`document`**: opinionated roxygen2 documentation standards,
  including shared-parameter setup via `@inheritParams`.
- **`search-code`**: AST-based code search and refactoring using
  [astgrepr](https://astgrepr.etiennebacher.com/).
- **`github`**: `gh` CLI usage and conventional commit message
  conventions.

## A workflow for agentic R package development

The skills above are designed to support a specific development
workflow. In practice, developing an R package with AI agents looks like
this:

1.  **Write a clear issue.** Use the `create-issue` skill (installed via
    [`use_skill_create_issue()`](https://api2r.github.io/pkgskills/reference/use_skill_create_issue.md))
    to produce a well-structured GitHub issue. The quality of the issue
    determines the quality of the agent’s output. A vague issue (“add a
    function that does X”) forces the agent to guess; a well-structured
    issue with a proposed function signature, argument descriptions,
    expected behavior, and edge cases gives the agent everything it
    needs to produce high-quality code with minimal back-and-forth.
    During development of this package, we spent the majority of our
    development time iterating with the Posit Assistant to ensure that
    the issues were clear.
2.  **Let the agent implement it.** Point the agent at the issue (either
    by assigning it to Copilot Coding Agent or by asking a local agent
    like Posit Assistant or Claude Code to implement it). The
    `implement-issue` skill guides it through the full cycle: fetch the
    issue, plan, write tests first, implement, document, run checks, and
    open a pull request for the issue.
3.  **Review the result.** The more time spent writing clear issues and
    refining skills, the less time needs to be spent on pull request
    reviews. You may also find that early issues require more review
    time than later issues, when your codebase can serve as a guide for
    future development.

### Writing good issues

The `create-issue` skill structures issue bodies with these sections:

| Section                 | Purpose                                                                                           |
|-------------------------|---------------------------------------------------------------------------------------------------|
| `## Summary`            | A single user-story sentence: “As a \[role\], in order to \[goal\], I would like to \[feature\].” |
| `## Proposed signature` | (Feature issues) The proposed function signature, argument descriptions, and return value.        |
| `## Behavior`           | Expected behavior and edge cases (features), or current vs. expected behavior (bugs).             |
| `## Details`            | Optional. Implementation details that don’t fit elsewhere.                                        |
| `## References`         | Optional. Related code, URLs, or prior art.                                                       |

## What Copilot Coding Agent accomplished

All development of pkgskills used Claude Sonnet 4.6 as the underlying
model. GitHub Copilot Coding Agent was used for autonomous PR-based
work, and Posit Assistant in RStudio (mostly with Claude Sonnet 4.6,
sometimes with Claude Opus 4.6) was used for interactive, conversational
development.

The following pull requests were implemented by GitHub Copilot Coding
Agent (with varying levels of human involvement) as real-world evidence
of what well-structured skills and issues enable:

- [\#8](https://github.com/api2r/pkgskills/pull/8)
- [\#12](https://github.com/api2r/pkgskills/pull/12)
- [\#13](https://github.com/api2r/pkgskills/pull/13)
- [\#14](https://github.com/api2r/pkgskills/pull/14)
- [\#16](https://github.com/api2r/pkgskills/pull/16)
- [\#21](https://github.com/api2r/pkgskills/pull/21)
- [\#22](https://github.com/api2r/pkgskills/pull/22)
- [\#23](https://github.com/api2r/pkgskills/pull/23)
- [\#24](https://github.com/api2r/pkgskills/pull/24)
- [\#27](https://github.com/api2r/pkgskills/pull/27)
- [\#29](https://github.com/api2r/pkgskills/pull/29)

These contributions validate that the workflow produces meaningful,
mergeable code when agents are given the right context.

## Refinement

After setting up your coding agent, we encourage you to refine
`AGENTS.md` and the skills to fit your style and philosophy. We’ve had a
lot of success by using an agent to make such refinements, with prompts
such as this:

> The skill in @.github/skills/r-code/SKILL.md was written for a
> different R package. Using the code in @R and @tests/testthat,
> customize the skill to match this package’s style and coding patterns.

If you find a particularly helpful refinement, we encourage you to
submit it back to the pkgskills package!
