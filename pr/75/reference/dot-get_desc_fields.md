# Get non-NA fields from DESCRIPTION

Get non-NA fields from DESCRIPTION

## Usage

``` r
.get_desc_fields(fields, call = caller_env())
```

## Arguments

- fields:

  (`character`) Field name(s) to read from `DESCRIPTION`.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`list`) Named list of non-`NA` field values from `DESCRIPTION`.
