FROM rocker/r-ver:4

# System tools needed for CI (git for actions/checkout, sudo for some actions)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        pandoc \
        git \
        sudo \
        curl \
        wget \
        rsync \
        ssh-client \
        libxml2-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfribidi-dev \
        libharfbuzz-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        qpdf \
    && rm -rf /var/lib/apt/lists/*

# actions/checkout needs this when running inside a container
RUN git config --global --add safe.directory '*'

# Install pak, then use it to install core CRAN packages.
# pak handles system dependency installation automatically on Ubuntu.
# These are the CRAN packages needed by copilot-setup-steps.yml plus
# all Imports/Suggests from DESCRIPTION. Gilead-BioStats/qcthat and
# local::. are left for runtime.
RUN Rscript -e 'install.packages("pak")'
RUN Rscript -e ' \
  pak::pak(c( \
    "astgrepr", \
    "callr", \
    "cli", \
    "covr", \
    "desc", \
    "devtools", \
    "fs", \
    "gh", \
    "knitr", \
    "magick", \
    "pkgdown", \
    "purrr", \
    "rcmdcheck", \
    "rlang", \
    "rmarkdown", \
    "roxygen2", \
    "wranglezone/stbl", \
    "stringr", \
    "testthat", \
    "usethis", \
    "withr", \
    "xml2" \
  ))'
