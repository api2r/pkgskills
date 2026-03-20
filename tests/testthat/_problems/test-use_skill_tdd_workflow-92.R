# Extracted from test-use_skill_tdd_workflow.R:92

# setup ------------------------------------------------------------------------
library(testthat)
test_env <- simulate_test_env(package = "pkgskills", path = "..")
attach(test_env, warn.conflicts = FALSE)

# test -------------------------------------------------------------------------
local_pkg(
    DESCRIPTION = c(
      "Title: My Package",
      "Version: 0.1.0"
    )
  )
