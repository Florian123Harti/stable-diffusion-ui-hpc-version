FROM ubuntu:bionic

COPY scripts /usr/local/bin/scripts

WORKDIR /usr/local/bin

ENTRYPOINT [ "scripts/nothing.sh" ]
