FROM ubuntu:22.04

USER root

# Tumhara wala error fix
RUN mkdir -p /var/lib/apt/lists/partial && \
    chmod -R 755 /var/lib/apt/lists && \
    apt-get update

CMD ["/bin/bash"]
