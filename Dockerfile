FROM ubuntu:artful

WORKDIR psychflow
COPY setup*.sh vars.sh cache/* /psychflow/

ENTRYPOINT /bin/bash

RUN bash -e setup.sh

# System specific setup
RUN bash -e setup-mosler.sh

WORKDIR /
RUN rm -rf psychflow
