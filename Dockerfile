FROM rust:slim

LABEL org.opencontainers.image.source="https://github.com/KiTechSoftware/gcr-rust"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    libssl-dev \
    pkg-config \
    dpkg-dev \
    rpm \
    gcc-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

# Install required cargo tools
RUN cargo install \
    cargo-audit \
    cargo-geiger \
    cargo-deny \
    cargo-deb \
    cargo-generate-rpm

# Copy Scripts
COPY scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Set working directory
WORKDIR /usr/src/app

ENTRYPOINT ["bash"]
