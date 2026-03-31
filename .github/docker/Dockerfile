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


# Install latest stable Rust toolchain into fixed, $HOME-independent paths so
# that pak can find cargo regardless of the HOME GitHub Actions injects at runtime.
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --no-modify-path
ENV PATH="/usr/local/cargo/bin:${PATH}"

# Register Rust with dpkg so pkgdepends' bundled sysreqs DB treats it as
# already installed and skips any apt/rustup install attempts at runtime.
RUN RUSTC_VER=$(rustc --version | awk '{print $2}') \
    && CARGO_VER=$(cargo --version | awk '{print $2}') \
    && printf 'Package: rustc\nStatus: install ok installed\nArchitecture: amd64\nVersion: %s\nDescription: stub; real Rust managed by rustup\n\nPackage: cargo\nStatus: install ok installed\nArchitecture: amd64\nVersion: %s\nDescription: stub; real Rust managed by rustup\n\n' \
       "$RUSTC_VER" "$CARGO_VER" >> /var/lib/dpkg/status

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

# Use pkgdepends' bundled sysreqs DB at runtime rather than downloading the
# live r-hub DB. The live DB's Rust rule runs rustup unconditionally (empty
# packages list bypasses the dpkg check), which fails inside GHA containers
# where HOME is remapped. The bundled DB uses a proper dpkg-based check.
# Rebuild the image with a newer pkgdepends to pick up bundled DB updates.
ENV PKG_SYSREQS_DB_UPDATE=false

# GitHub Copilot's injected "Prepare Copilot" step uses `set -o pipefail` via
# `shell: sh`, which dash (Debian's default /bin/sh) doesn't support.  Redirect
# /bin/sh to bash, which is already installed and is a superset of POSIX sh.
# Placed last so no apt postinst script can overwrite the symlink during build.
RUN ln -sf /bin/bash /bin/sh
