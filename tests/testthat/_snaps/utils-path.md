# .path_proj_save_as() errors when file exists and overwrite = FALSE (#noissue)

    Code
      (expect_pkg_error_classes(.path_proj_save_as("output.md", overwrite = FALSE),
      "pkgskills", "file_exists"))
    Output
      <error/pkgskills-error-file_exists>
      Error:
      ! File 'PATH' already exists.

# .check_path_writable() errors when file exists and overwrite = FALSE (#noissue)

    Code
      (expect_pkg_error_classes(.check_path_writable(tmp, overwrite = FALSE),
      "pkgskills", "file_exists"))
    Output
      <error/pkgskills-error-file_exists>
      Error:
      ! File 'PATH' already exists.

