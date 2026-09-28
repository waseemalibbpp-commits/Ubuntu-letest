FROM bandi13/gui-docker

USER root

RUN apt-get update && \
    apt-get install -y \
    firefox \
    git \
    nano \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*

USER dockerUser
