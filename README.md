Present sample Application is built for the [Google Coral Dev Board](https://coral.ai/products/dev-board/)

This repository provides an example that sets up the TPU accelerator, so that it can be used from within a container running on balenaOS on the Google Coral Dev Board.

The `Dockerfile` and `run.sh` script contain comments regarding the installation of various packages that are needed to run the sample provided by Google.

Actual output observed when running the Google image classification sample in this APP:

> 19.12.19 10:37:06 (+0200)  main  Running sample: /usr/share/edgetpu/examples/classify_image.py
> 19.12.19 10:37:07 (+0200)  main  ---------------------------
> 19.12.19 10:37:07 (+0200)  main  Ara macao (Scarlet Macaw)
> 19.12.19 10:37:07 (+0200)  main  Score :  0.613281
> 19.12.19 10:37:07 (+0200)  main  ---------------------------
> 19.12.19 10:37:07 (+0200)  main  Platycercus elegans (Crimson Rosella)
> 19.12.19 10:37:07 (+0200)  main  Score :  0.152344

This application was built based on the mendel-chef distribution, using documentation available at: https://coral.ai/examples/classify-image/
