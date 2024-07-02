# Runtime
ARG VARIANT="bullseye"
FROM mcr.microsoft.com/devcontainers/go:1-bullseye

# - Setup
ENV HOME="/home/vscode"
WORKDIR /home/vscode

# - Install standard packages
RUN apt-get update && \
        # General purpose tools
    apt-get install -y curl git \
        software-properties-common \
        gnupg2 apt-transport-https openssh-client vim \
        # Tools
        ripgrep jq;

USER vscode

RUN sudo chown -R vscode /usr/local/bin

# - Install tools from Docker
COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin
COPY --from=alpine/helm /usr/bin/helm /usr/local/bin

# - Install tenv
ARG TENV_VERSION="v2.2.1"
RUN curl -O -L "https://github.com/tofuutils/tenv/releases/latest/download/tenv_${TENV_VERSION}_amd64.deb"
RUN sudo dpkg -i "tenv_${TENV_VERSION}_amd64.deb"

# - Install tools with scripts
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# - Set up Git
RUN git config --global user.name "Ivan Lee"
RUN git config --global user.email "ivanklee86@gmail.com"
RUN git config --global push.autoSetupRemote true