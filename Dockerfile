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
# RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# RUN install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
# RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# RUN apt update
# RUN apt install -y code

RUN wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
deb [signed-by=/etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main
RUN apt update
RUN apt install codium

USER balloon

COPY run-code.sh /usr/bin/vscode
