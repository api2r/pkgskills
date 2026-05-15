test_that("update_ai() defaults overwrite to TRUE (#noissue)", {
  local_pkg()
  local_gh_mock()
  local_mocked_bindings(
    use_ai = function(
      save_agent_as,
      target_skills_dir,
      use_skills_subdir,
      overwrite,
      open,
      gh_token,
      allowlist,
      skills
    ) {
      expect_true(overwrite)
      invisible("ok")
    }
  )

  result <- withVisible(update_ai(open = FALSE, skills = "r-code"))
  expect_false(result$visible)
  expect_identical(result$value, "ok")
})

test_that("update_ai() still allows explicit overwrite = FALSE (#noissue)", {
  local_pkg()
  local_gh_mock()
  local_mocked_bindings(
    use_ai = function(
      save_agent_as,
      target_skills_dir,
      use_skills_subdir,
      overwrite,
      open,
      gh_token,
      allowlist,
      skills
    ) {
      expect_false(overwrite)
      invisible("ok")
    }
  )

  result <- withVisible(update_ai(
    overwrite = FALSE,
    open = FALSE,
    skills = "r-code"
  ))
  expect_false(result$visible)
  expect_identical(result$value, "ok")
})
