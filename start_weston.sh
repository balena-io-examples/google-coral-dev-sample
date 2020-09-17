#!/bin/bash

# The correct driver comes from google repository's
# imx-gpu-viv deb package. The BSP oot kernel module doesn't
# play well with weston-imx.
+bash /etc/runonce.d/00-disable-tsched.sh
+
+/usr/bin/pulseaudio --daemonize=no &

cd /usr/src/app && insmod galcore.ko

echo "XDG_RUNTIME_DIR=/tmp/" > /etc/environment

mkdir /tmp/.X11-unix/

/usr/bin/weston-launch --tty /dev/tty7 -u root


