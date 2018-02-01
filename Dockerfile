FROM ubuntu:xenial

COPY setup*.sh vars.sh cache/* /psychflow/

RUN bash -e /psychflow/setup.sh
ENV PATH ${PATH:+$PATH:}/opt/EIG-7.2.1/bin
ENV PATH ${PATH:+$PATH:}/opt/rp_bin:/usr/rp_bin/pdfjam

# Necessary?
#ENV QT_XKB_CONFIG_ROOT /usr/share/X11/xkb

