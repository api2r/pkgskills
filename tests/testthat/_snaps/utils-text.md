# .parse_yaml_front_matter() errors when no delimiters found (#noissue)

    Code
      (stbl::expect_pkg_error_classes(.parse_yaml_front_matter(lines, "test.md"),
      "pkgskills", "no_front_matter"))
    Output
      <error/pkgskills-error-no_front_matter>
      Error:
      ! No YAML front matter found in 'test.md'.

# .parse_yaml_front_matter() errors when only one delimiter found (#noissue)

    Code
      (stbl::expect_pkg_error_classes(.parse_yaml_front_matter(lines, "test.md"),
      "pkgskills", "no_front_matter"))
    Output
      <error/pkgskills-error-no_front_matter>
      Error:
      ! No YAML front matter found in 'test.md'.

# .extract_yaml_scalar() errors when field not found (#noissue)

    Code
      (stbl::expect_pkg_error_classes(.extract_yaml_scalar(front_matter, "trigger",
        "test.md"), "pkgskills", "no_trigger"))
    Output
      <error/pkgskills-error-no_trigger>
      Error:
      ! No trigger field in front matter of 'test.md'.

