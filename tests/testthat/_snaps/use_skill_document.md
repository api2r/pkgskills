# use_skill_document() emits message when aaa-shared_params.R is created (#9, #81)

    Code
      (expect_pkg_message_classes({
        expect_message(use_skill_document(open = FALSE), class = "pkgskills-message-ai_implementation-skill")
      }, "pkgskills", "shared_file", "params"))
    Output
      <message/pkgskills-message-shared_file-params>
      Message in `use_skill_document()`:
      'R/aaa-shared_params.R' created.
      i Add shared parameters to it as your package grows. Functions can inherit shared parameters with `@inheritParams .shared-params`.

