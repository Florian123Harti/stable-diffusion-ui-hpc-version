FROM ubuntu:bionic

RUN apt update
RUN apt install -y git curl 

COPY scripts /usr/local/bin/scripts

WORKDIR /usr/local/bin

RUN ["/bin/bash", "-c", "scripts/start.sh"]

ENTRYPOINT [ "scripts/nothing.sh" ]
