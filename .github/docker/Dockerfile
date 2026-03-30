ARG R_VERSION=4
FROM rocker/r-ver:${R_VERSION}

# Baseline tools that GHA runners normally provide. Actions (codecov, cache,
# upload-artifact, …) expect many of these to exist; installing them here
# avoids "missing dependency" errors when jobs run inside this container.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # — core CI plumbing --------------------------------------------------
        git \
        sudo \
        curl \
        wget \
        rsync \
        ssh-client \
        gnupg2 \
        jq \
        file \
        locales \
        lsb-release \
        # — archive / compression (actions/cache, upload-artifact, etc.) ------
        tar \
        unzip \
        zip \
        xz-utils \
        zstd \
        # — build tools -------------------------------------------------------
        make \
        gcc \
        g++ \
        pkg-config \
        cmake \
        # — R build system libs -----------------------------------------------
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
        # — document tooling --------------------------------------------------
        pandoc \
        qpdf \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.UTF-8

# actions/checkout needs this when running inside a container
RUN git config --global --add safe.directory '*'


# Install latest stable Rust toolchain (rocker images may ship an outdated version)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Rocker images configure repos to PPM's Linux binary endpoint, which doesn't
# index packages needing non-standard build tools (e.g. Rust). Add CRAN source
# as a permanent fallback so pak can always resolve the full CRAN catalogue.
RUN echo 'local({ \
  repos <- getOption("repos"); \
  if (!"CRAN_SRC" %in% names(repos)) \
    options(repos = c(repos, CRAN_SRC = "https://cloud.r-project.org")) \
})' >> "$(R RHOME)/etc/Rprofile.site"

# Install pak, then R packages (filtered by compatibility with this R version)
RUN Rscript -e 'install.packages("pak")'
COPY install-packages.R /tmp/install-packages.R
RUN Rscript /tmp/install-packages.R && rm /tmp/install-packages.R
