# use_skill_r_code() emits messages (#19, #81)

    Code
      (expect_pkg_message_classes({
        expect_message(use_skill_r_code(open = FALSE), class = "pkgskills-message-ai_implementation-skill")
      }, "pkgskills", "shared_file", "conditions"))
    Output
      <message/pkgskills-message-shared_file-conditions>
      Message in `.use_conditions()`:
      'R/aaa-conditions.R' created or updated.
      i Use `.pkg_abort()` for package errors. Add more error helpers here as your package grows.

