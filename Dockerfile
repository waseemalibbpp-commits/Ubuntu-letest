FROM ubuntu:22.04

# Root user se start
USER root

ENV DEBIAN_FRONTEND=noninteractive

# Ye tumhara error fix karega
RUN rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/apt/lists/partial && \
    chmod -R 755 /var/lib/apt/lists

# Update + halka browser + zaroori tools
RUN apt-get update && apt-get install -y \
    chromium-browser \
    midori \
    curl \
    wget \
    sudo \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/apt/lists/partial && chmod -R 755 /var/lib/apt/lists

# dockerUser banao aur sudo do
RUN useradd -m -s /bin/bash dockerUser && \
    echo "dockerUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ab user switch karo
USER dockerUser
WORKDIR /home/dockerUser

CMD ["/bin/bash"]
