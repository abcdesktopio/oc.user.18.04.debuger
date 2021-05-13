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
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
  install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
  sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' && \
  rm -f packages.microsoft.gpg

RUN apt update
RUN apt install code

USER balloon

COPY run-code.sh /usr/bin/vscode
