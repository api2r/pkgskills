# Coerce to a non-null, non-empty character scalar

Coerce to a non-null, non-empty character scalar

## Usage

``` r
.to_string(x, x_arg = caller_arg(x), call = caller_env())
```

## Arguments

- x:

  (`any`) The value to coerce.

- x_arg:

  (`character(1)`) Argument name for `x`, used in error messages.

- call:

  (`environment`) The caller environment for error messages.

## Value

(`character(1)`) `x` coerced to a character scalar.
