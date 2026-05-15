# use_agent() emits an informational message after writing (#2, #81)

    Code
      (expect_pkg_message_classes({
        use_agent(open = FALSE)
      }, "pkgskills", "ai_implementation", "agent"))
    Output
      <message/pkgskills-message-ai_implementation-agent>
      Message in `use_agent()`:
      'AGENTS.md' created.
      i To tailor it to your project, tell your AI agent this: "Tailor @AGENTS.md to reflect this repository's actual structure. Focus on the **Repository overview** and the **Key files** table."

