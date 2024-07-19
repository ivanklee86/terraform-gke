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
COPY --from=derailed/k9s /bin/k9s /usr/local/bin

# - Install tenv
RUN TENV_URL=`curl -s https://api.github.com/repos/tofuutils/tenv/releases/latest | grep '"browser_download_url":' | grep 'amd64.deb' | grep -vE '(\.pem|\.sig|\.gpgsig)' | grep -o 'https://[^"]*'` && \
    curl -O -L $TENV_URL && \
    sudo dpkg -i "${TENV_URL##*/}"

# - Install tools with go
RUN go install github.com/terraform-docs/terraform-docs@v0.18.0

# - Install tools with scripts
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
RUN curl -sSL https://sdk.cloud.google.com | bash

# - Set up Git
RUN git config --global push.autoSetupRemote true

# - Set up PATH
ENV PATH $PATH:/home/vscode/google-cloud-sdk/bin

# - Modify dotfiles
RUN echo 'alias k=kubectl' >> ~/.bashrc