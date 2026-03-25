test_that(".find_pattern_idx() returns index of first match (#noissue)", {
  lines <- c("apple", "banana", "cherry")
  expect_identical(.find_pattern_idx(lines, "^ban"), 2L)
})

test_that(".find_pattern_idx() returns integer(0) when no match (#noissue)", {
  lines <- c("apple", "banana", "cherry")
  expect_identical(.find_pattern_idx(lines, "^mango"), integer(0))
})

test_that(".find_pattern_idx() returns first index when multiple match (#noissue)", {
  lines <- c("foo", "bar", "foo", "baz")
  expect_identical(.find_pattern_idx(lines, "^foo"), 1L)
})

test_that(".find_pattern_idx() works with stringr::fixed() pattern (#noissue)", {
  lines <- c("path/a.md", "path/b.md", "other")
  expect_identical(.find_pattern_idx(lines, stringr::fixed("path/b.md")), 2L)
})

test_that(".find_table_last_row_idx() returns integer(0) when no table rows (#noissue)", {
  lines <- c("# Heading", "", "Some prose.")
  expect_identical(.find_table_last_row_idx(lines, 0L), integer(0))
})

test_that(".find_table_last_row_idx() returns last contiguous table row (#noissue)", {
  lines <- c("## Section", "| a | b |", "|---|---|", "| 1 | 2 |", "", "## Next")
  expect_identical(.find_table_last_row_idx(lines, 1L), 4L)
})

test_that(".find_table_last_row_idx() stops after first non-table line (#noissue)", {
  lines <- c("## Section", "| a |", "prose", "| b |")
  expect_identical(.find_table_last_row_idx(lines, 1L), 2L)
})

test_that(".parse_yaml_front_matter() returns lines between --- delimiters (#noissue)", {
  lines <- c("---", "name: test", "trigger: do thing", "---", "# Content")
  result <- .parse_yaml_front_matter(lines, "test.md")
  expect_identical(result, c("name: test", "trigger: do thing"))
})

test_that(".parse_yaml_front_matter() errors when no delimiters found (#noissue)", {
  lines <- c("# No front matter", "Just content.")
  stbl::expect_pkg_error_snapshot(
    .parse_yaml_front_matter(lines, "test.md"),
    "pkgskills",
    "no_front_matter"
  )
})

test_that(".parse_yaml_front_matter() returns character(0) for empty front matter (#noissue)", {
  lines <- c("---", "---", "# Content")
  result <- .parse_yaml_front_matter(lines, "test.md")
  expect_identical(result, character(0))
})

test_that(".parse_yaml_front_matter() errors when only one delimiter found (#noissue)", {
  lines <- c("---", "name: test", "# No closing delimiter")
  stbl::expect_pkg_error_snapshot(
    .parse_yaml_front_matter(lines, "test.md"),
    "pkgskills",
    "no_front_matter"
  )
})

test_that(".extract_yaml_scalar() returns trimmed value for existing field (#noissue)", {
  front_matter <- c("name: my-skill", "trigger: do the thing")
  result <- .extract_yaml_scalar(front_matter, "trigger", "test.md")
  expect_identical(result, "do the thing")
})

test_that(".extract_yaml_scalar() trims leading whitespace from value (#noissue)", {
  front_matter <- c("trigger:   spaced value  ")
  result <- .extract_yaml_scalar(front_matter, "trigger", "test.md")
  expect_identical(result, "spaced value")
})

test_that(".extract_yaml_scalar() errors when field not found (#noissue)", {
  front_matter <- c("name: my-skill")
  stbl::expect_pkg_error_snapshot(
    .extract_yaml_scalar(front_matter, "trigger", "test.md"),
    "pkgskills",
    "no_trigger"
  )
})

test_that(".lines_insert_after() inserts after given index (#noissue)", {
  lines <- c("a", "b", "c")
  result <- .lines_insert_after(lines, 2L, c("x", "y"))
  expect_identical(result, c("a", "b", "x", "y", "c"))
})

test_that(".lines_insert_after() inserts after last index (#noissue)", {
  lines <- c("a", "b", "c")
  result <- .lines_insert_after(lines, 3L, "z")
  expect_identical(result, c("a", "b", "c", "z"))
})

test_that(".lines_insert_after() inserts before all lines when idx is 0 (#noissue)", {
  lines <- c("a", "b", "c")
  result <- .lines_insert_after(lines, 0L, "z")
  expect_identical(result, c("z", "a", "b", "c"))
})
