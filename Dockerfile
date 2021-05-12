ARG TAG=dev

FROM abcdesktopio/oc.user.18.04:$TAG

USER root

RUN chown -R balloon:balloon /composer/node

RUN apt update \
  && apt install -y g++ \
  && apt install -y make \
  && apt install -y g++ \
  && apt install apt-transport-https

# Vscode installation
RUN apt install snapd
RUN snap install vscode 

USER balloon

COPY run-code.sh /usr/bin/vscode
