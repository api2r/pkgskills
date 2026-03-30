ARG R_VERSION=4
FROM rocker/r-ver:${R_VERSION}

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
        libmagick++-dev \
        libpng-dev \
        libtiff-dev \
        cmake \
        qpdf \
    && rm -rf /var/lib/apt/lists/*

# actions/checkout needs this when running inside a container
RUN git config --global --add safe.directory '*'

# Install latest stable Rust toolchain (rocker images may ship an outdated version)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install pak, then R packages (filtered by compatibility with this R version)
RUN Rscript -e 'install.packages("pak")'
COPY install-packages.R /tmp/install-packages.R
RUN Rscript /tmp/install-packages.R && rm /tmp/install-packages.R
