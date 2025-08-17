# Use Debian slim as base image for reduced size
FROM debian:12-slim

# Install system dependencies for downloading and extracting packages
RUN apt update && apt install -y --no-install-recommends \
    curl wget tar xz-utils ca-certificates jq unzip git build-essential \
    openssh-client fontconfig fonts-noto fonts-noto-cjk lmodern \
    fonts-noto-color-emoji fonts-dejavu fonts-liberation \
    fonts-inconsolata fonts-firacode r-base locales \
    # libxml2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Install tools in a single layer to reduce image size
RUN DENO_VERSION=$(curl -s https://api.github.com/repos/denoland/deno/releases/latest | jq -r '.tag_name' | sed 's/^v//') && \
    curl -fsSL "https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip" -o /tmp/deno.zip && \
    unzip /tmp/deno.zip -d /tmp && mv /tmp/deno /usr/local/bin/ && chmod +x /usr/local/bin/deno && rm /tmp/deno.zip && \
    PANDOC_VERSION=$(curl -s https://api.github.com/repos/jgm/pandoc/releases/latest | jq -r '.tag_name') && \
    curl -fsSL "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz" | tar -xz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/pandoc /usr/local/bin/ && rm -rf /tmp/pandoc-${PANDOC_VERSION} && \
    TYPST_VERSION=$(curl -s https://api.github.com/repos/typst/typst/releases/latest | jq -r '.tag_name' | sed 's/^v//') && \
    curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" | tar -xJ -C /tmp && \
    mv /tmp/typst-x86_64-unknown-linux-musl/typst /usr/local/bin/ && chmod +x /usr/local/bin/typst && rm -rf /tmp/typst-x86_64-unknown-linux-musl && \
    QUARTO_VERSION=$(curl -s https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq -r '.tag_name' | sed 's/^v//') && \
    curl -fsSL "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz" | tar -xz -C /tmp && \
    mv /tmp/quarto-${QUARTO_VERSION} /opt/quarto && ln -s /opt/quarto/bin/quarto /usr/local/bin/quarto && chmod +x /usr/local/bin/quarto && rm -rf /tmp/quarto-${QUARTO_VERSION} && \
    curl -fsSL "https://yihui.org/tinytex/install-bin-unix.sh" | sh && \
    export PATH="/root/.TinyTeX/bin/x86_64-linux:$PATH" && /root/.TinyTeX/bin/x86_64-linux/tlmgr path add && \
    tlmgr update --self && \
    tlmgr option repository https://mirror.ctan.org/systems/texlive/tlnet && \
    tlmgr install soul fancyhdr pgf caption
    # tlmgr install pgf caption

# Set locale to en_GB.UTF-8
RUN echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_GB.UTF-8 && \
    update-locale LANG=en_GB.UTF-8

ENV LANG=en_GB.UTF-8 \
    LC_ALL=en_GB.UTF-8

# Set PATH for TinyTeX
ENV PATH="/root/.TinyTeX/bin/x86_64-linux:$PATH"

# Create working directory
WORKDIR /workspace
# Install R packages: knitr and rmarkdown
RUN Rscript -e 'install.packages(c("knitr", "rmarkdown"), repos="https://cloud.r-project.org/")'

# Verify installations
RUN typst --version && quarto --version && git --version && tlmgr --version

# Default command
CMD ["/bin/sh"]
