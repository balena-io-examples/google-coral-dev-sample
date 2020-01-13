Present sample Application is built for the [Google Coral Dev Board](https://coral.ai/products/dev-board/)

This repository provides an example that sets up the TPU accelerator, so that it can be used from within a container running on balenaOS on the Google Coral Dev Board.

The `Dockerfile` contains comments regarding the installation of various packages that are needed to run the sample python application provided by Google.

Actual output observed when running the Google image classification python sample in this APP:

> 19.12.19 10:37:06 (+0200)  main  Running sample: /usr/share/edgetpu/examples/classify_image.py

> 19.12.19 10:37:07 (+0200)  main  ---------------------------

> 19.12.19 10:37:07 (+0200)  main  Ara macao (Scarlet Macaw)

> 19.12.19 10:37:07 (+0200)  main  Score :  0.613281


This application was built based on the mendel-chef distribution, using documentation available at: https://coral.ai/examples/classify-image/

For GStreamer use-cases, the imx packages can be set-up by uncommenting the following line in the Dockerfile:

> RUN apt-get update && apt-get install gstreamer1.0-plugins-base=1.12.2+imx-2 libgstreamer1.0-0=1.12.2+imx-2 libgstreamer-plugins-base1.0-0=1.12.2+imx-2 imx-gst1.0-plugin=4.3.4-4 gstreamer1.0-plugins-good=1.12.2+imx-4 gstreamer1.0-plugins-base-apps=1.12.2+imx-2 gstreamer1.0-tools=1.12.2+imx-2 gstreamer1.0-plugins-bad=1.12.2+imx-5 gstreamer1.0-pulseaudio=1.12.2+imx-4 libdrm-vivante=2.4.84+imx-mendel2 libdrm-libkms=2.4.84+imx-mendel2 wayland-protocols=1.13+imx-2 libgstreamer-plugins-bad1.0-0=1.12.2+imx-5

NOTE: The above packages are commented out and not installed by default in the Dockerfile as this will lead to an increase of the overall image size.
It is recommended to always install only the packages that are going to be used in the target application.

In order to check gstreamer installation:

> gst-inspect-1.0 | grep vpu

> vpu.imx:  vpudec: VPU-based video decoder

Sample GStreamer Video playback:

> export XDG_RUNTIME_DIR=/tmp/

> gst-launch-1.0 playbin uri=file:///usr/src/app/MyMP4VideoFile.mp4 video-sink=waylandsink

Gstreamer debug logs during playback:

> 0:00:00.000695404 19289 0xaaab0436ea00 INFO            GST_INIT gst.c:528:init_pre: Linux 645aea8 4.9.51-imx #1 SMP PREEMPT Tue Jan 7 08:34:00 UTC 2020 aarch64

> 0:00:00.276007173 19289 0xaaab0436ea00 DEBUG           GST_REGISTRY gstregistrychunks.c:878:_priv_gst_registry_chunks_load_plugin: Added plugin 'imxcompositor.imx' plugin with 0 features from binary registry

> 0:00:00.321025942 19289 0xaaab0436ea00 DEBUG           GST_REGISTRY gstregistrychunks.c:878:_priv_gst_registry_chunks_load_plugin: Added plugin 'vpu.imx' plugin with 1 features from binary registry

NOTE: Video output using this sample APP is available for the Google Coral-Dev starting with BalenaOS 2.46

