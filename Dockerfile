FROM dorowu/ubuntu-desktop-lxde-vnc:focal

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1280x720

# Zaroori apps install
RUN apt-get update && apt-get install -y \
    xfce4-terminal \
    xterm \
    dbus-x11 \
    chromium-browser \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# User ko permission do
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Black screen fix + Railway PORT fix
RUN echo '#!/bin/bash\n\
service dbus start\n\
/usr/local/bin/startup.sh &\n\
sleep 4\n\
if [ -z "$PORT" ]; then PORT=8080; fi\n\
/usr/bin/python3 -m websockify --web=/usr/share/novnc/ $PORT localhost:5901\n\
' > /start-railway.sh && chmod +x /start-railway.sh

CMD ["/start-railway.sh"]

EXPOSE 8080
