# Built based on documentation available at: https://coral.ai/examples/classify-image/
FROM balenalib/coral-dev-ubuntu:bionic

# Ensure package install won't block for user input during build
ENV DEBIAN_FRONTEND=noninteractive

# Add google repositories
RUN \
    echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-bsp-enterprise-day main \n deb-src https://packages.cloud.google.com/apt mendel-bsp-enterprise-day main" \
    | tee /etc/apt/sources.list.d/multistrap-bsp.list && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-day main \n deb-src https://packages.cloud.google.com/apt mendel-day main" \
    | tee /etc/apt/sources.list.d/multistrap-main.list

# Install Coral Dev samples and dependencies
RUN \
    apt-get update && apt-get install -y libedgetpu1-std \
    libedgetpu-dev \
    python3-edgetpu \
    edgetpu-examples \
    python3-pip \
    imx-gpu-viv \
    weston-imx

# Uncomment these for video output
#RUN \
#    apt-get install -y gstreamer1.0-plugins-base=1.14.4+imx-5 \
#    libgstreamer1.0-0=1.14.4+imx-3 \
#    libgstreamer-plugins-base1.0-0=1.14.4+imx-5 \
#    imx-gst1.0-plugin=4.4.5-5 \
#    gstreamer1.0-plugins-good=1.14.4+imx-5 \
#    gstreamer1.0-plugins-bad=1.14.4+imx-7 \
#    libdrm-vivante=2.4.84+imx-mendel3 \
#    libgstreamer-plugins-bad1.0-0=1.14.4+imx-7 \
#    libgstreamer-gl1.0-0=1.14.4+imx-5 \
#    gstreamer1.0-python3-plugin-loader=1.14.4-1+b1 \
#    python3-gst-1.0=1.14.4-1+b1 \
#    gstreamer1.0-plugins-ugly=1.14.4-1 \
#    gir1.2-gst-plugins-base-1.0=1.14.4-2 \
#    gir1.2-gstreamer-1.0=1.14.4-1 \
#    gstreamer1.0-gl=1.14.4+imx-5 \
#    gstreamer1.0-tools=1.14.4+imx-3 \
#    libdrm-libkms=2.4.84+imx-mendel3 \
#    wayland-protocols=1.17+imx-1 \
#    python3-edgetpuvision

# Uncomment these also if using audio
#RUN \
#    apt-get install -y --allow-downgrades \
#    pulseaudio-utils=12.2-4+deb10u1 \
#    libpulse0=12.2-4+deb10u1 \
#    libpulsedsp=12.2-4+deb10u1 \
#    pulseaudio=12.2-4+deb10u1 \
#    imx-board-audio=5-1 \
#    alsa-utils=1.1.8-2 \
#    gstreamer1.0-alsa=1.14.4+imx-5 \
#    wget

WORKDIR /usr/src/app

RUN \
    find /lib/modules -type f -name 'galcore.ko' -print0 | xargs -0 -I{} cp {} /usr/src/app/galcore.ko

COPY run_sample.sh run_sample.sh
COPY start_weston.sh start_weston.sh

ENV UDEV=1

CMD ["bash","run_sample.sh"]
