FROM dorowu/ubuntu-desktop-lxde-vnc:focal

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1280x720

# Railway ka PORT variable use karna lazmi hai
CMD bash -c "echo $PORT && /usr/local/bin/startup.sh & bash -c 'sleep 3; /usr/bin/python3 -m websockify --web=/usr/share/novnc/ $PORT localhost:5901' && wait"
