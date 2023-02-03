FROM ubuntu:bionic

RUN apt update
RUN apt install -y git curl 

COPY scripts /usr/local/bin/scripts

WORKDIR /usr/local/bin

ENTRYPOINT [ "scripts/nothing.sh" ]
