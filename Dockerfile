FROM ubuntu:bionic

RUN apt update
RUN apt install -y git curl nano openssh-client
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

COPY scripts /usr/local/bin/scripts
COPY ui /usr/local/bin/ui

WORKDIR /usr/local/bin

RUN ["/bin/bash", "-c", "scripts/start.sh"]
RUN ["/bin/bash", "-c", "scripts/load_gfpgan_weights.sh"]

SHELL ["/bin/bash", "-c"]
ENTRYPOINT [ "scripts/docker-entrypoint.sh" ]
