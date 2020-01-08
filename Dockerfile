# Built based on documentation available at: https://coral.ai/examples/classify-image/
FROM balenalib/coral-dev-ubuntu:bionic

# Ensure package install won't block for user input during build
ENV DEBIAN_FRONTEND=noninteractive

# Add google repositories
RUN \
    echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-bsp-enterprise-chef main \n deb-src https://packages.cloud.google.com/apt mendel-bsp-enterprise-chef main" \
    | tee /etc/apt/sources.list.d/multistrap-bsp.list && \
    printf "deb [arch=arm64] https://packages.cloud.google.com/apt mendel-chef main \n deb-src https://packages.cloud.google.com/apt mendel-chef main" \
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

#RUN \
#    apt-get update && apt-get install -y gstreamer1.0-plugins-base=1.12.2+imx-2 \
#    libgstreamer1.0-0=1.12.2+imx-2 \
#    libgstreamer-plugins-base1.0-0=1.12.2+imx-2 \
#    imx-gst1.0-plugin=4.3.4-4 \
#    gstreamer1.0-plugins-good=1.12.2+imx-4 \
#    gstreamer1.0-plugins-base-apps=1.12.2+imx-2 \
#    gstreamer1.0-tools=1.12.2+imx-2 \
#    gstreamer1.0-plugins-bad=1.12.2+imx-5 \
#    gstreamer1.0-pulseaudio=1.12.2+imx-4 \
#    libdrm-vivante=2.4.84+imx-mendel2 \
#    libdrm-libkms=2.4.84+imx-mendel2 \
#    wayland-protocols=1.13+imx-2 \
#    libgstreamer-plugins-bad1.0-0=1.12.2+imx-5

WORKDIR /usr/src/app

RUN \
    find /lib/modules -type f -name 'galcore.ko' -print0 | xargs -0 -I{} cp {} /usr/src/app/galcore.ko

COPY run_sample.sh run_sample.sh
COPY start_weston.sh start_weston.sh

ENV UDEV=1

CMD ["bash","run_sample.sh"]
