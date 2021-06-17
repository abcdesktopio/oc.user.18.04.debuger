ARG TAG=dev

# Default base image 
ARG BASE_IMAGE=abcdesktopio/oc.user.18.04

FROM $BASE_IMAGE:$TAG

USER root

RUN chown -R balloon:balloon /composer/node

RUN apt update \
  && apt install -y g++ \
  && apt install -y make \
  && apt install -y g++ \
  && apt install -y apt-transport-https \
  && apt install -y wget

# Vscode installation
COPY code_1.57.0_amd64.deb /
RUN dpkg -i /code_1.57.0_amd64.deb

USER balloon

COPY run-code.sh /usr/bin/vscode
