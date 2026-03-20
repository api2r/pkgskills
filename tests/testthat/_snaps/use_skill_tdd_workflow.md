# use_skill_tdd_workflow() emits inform message when helper is created (#11)

    Code
      use_skill_tdd_workflow(open = FALSE)
    Message
      Skill '.github/skills/tdd-workflow/SKILL.md' installed.
      'tests/testthat/helper-expectations.R' created.
      i Inspect the helper and add any project-specific `transform()` functions as needed.

# use_skill_tdd_workflow() does not emit helper message when it already exists (#11)

    Code
      use_skill_tdd_workflow(open = FALSE)
    Message
      Skill '.github/skills/tdd-workflow/SKILL.md' installed.

