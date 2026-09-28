FROM ubuntu:22.04

USER root
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /var/lib/apt/lists/partial && chmod -R 755 /var/lib/apt/lists

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-terminal \
    x11vnc xvfb \
    novnc net-tools \
    chromium-browser \
    sudo && apt-get clean

RUN useradd -m -s /bin/bash dockerUser && \
    echo "dockerUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# VNC start script
RUN mkdir -p /home/dockerUser/.vnc
CMD bash -c "Xvfb :1 -screen 0 1280x720x24 & sleep 2; x11vnc -display :1 -nopw -forever & startxfce4 & novnc --listen 6901 --vnc localhost:5900 & wait"

EXPOSE 6901 5900
