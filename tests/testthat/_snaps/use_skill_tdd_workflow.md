# use_skill_tdd_workflow() emits messages (#11, #52)

    Code
      (expect_pkg_message_classes({
        expect_message(use_skill_tdd_workflow(open = FALSE), class = "pkgskills-message-ai_implementation-skill")
      }, "pkgskills", "shared_file", "test_conditions"))
    Output
      <message/pkgskills-message-shared_file-test_conditions>
      Message in `.use_conditions_tests()`:
      'tests/testthat/test-aaa-conditions.R' created or updated.

# use_skill_tdd_workflow() errors when Package field is absent (#11)

    Code
      (expect_pkg_error_classes(use_skill_tdd_workflow(open = FALSE), "pkgskills",
      "no_package_field"))
    Output
      <error/pkgskills-error-no_package_field>
      Error in `use_skill_tdd_workflow()`:
      ! No Package field found in 'DESCRIPTION'.

