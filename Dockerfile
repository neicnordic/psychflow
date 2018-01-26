FROM ubuntu:artful

RUN apt-get update && apt-get install -y git wget build-essential locales
RUN git clone https://github.com/neicnordic/psychflow.git

COPY cache/* /psychflow/

ENTRYPOINT /bin/bash

WORKDIR psychflow
RUN bash -e setup.sh

# System specific setup
RUN bash setup-mosler.sh

WORKDIR /
RUN rm -rf psychflow
