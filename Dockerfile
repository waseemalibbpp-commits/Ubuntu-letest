FROM dorowu/ubuntu-desktop-lxde-vnc:focal

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1280x720

# Add Google Chrome GPG key and update
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FD533C07C264648F || true

# Update packages
RUN apt-get update && apt-get install -y \
    xfce4-terminal \
    xterm \
    dbus-x11 \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Railway fix
RUN printf '#!/bin/bash\\nservice dbus start\\n/usr/local/bin/startup.sh &\\nsleep 4\\nif [ -z "$PORT" ]; then PORT=8080; fi\\n/usr/bin/python3 -m websockify --web=/usr/share/novnc/ $PORT localhost:5901\\n' > /start-railway.sh && chmod +x /start-railway.sh

CMD ["/start-railway.sh"]

