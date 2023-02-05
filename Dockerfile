FROM ubuntu:bionic

RUN apt update
RUN apt install -y git curl nano openssh-client

COPY scripts /usr/local/bin/scripts
COPY ui /usr/local/bin/ui

WORKDIR /usr/local/bin

RUN ["/bin/bash", "-c", "scripts/start.sh"]
RUN ["/bin/bash", "-c", "scripts/load_gfpgan_files.sh"]

SHELL ["/bin/bash", "-c"]
ENTRYPOINT [ "scripts/docker-entrypoint.sh" ]
