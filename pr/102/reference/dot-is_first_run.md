# Identify elements belonging to the first contiguous run

Identify elements belonging to the first contiguous run

## Usage

``` r
.is_first_run(x)
```

## Arguments

- x:

  (`integer`) A sorted integer vector.

## Value

(`logical`) `TRUE` for each element that belongs to the first unbroken
run (no gap of more than 1 between consecutive values), `FALSE` once a
gap is encountered.
