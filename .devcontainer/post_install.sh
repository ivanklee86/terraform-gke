#!/bin/bash
set -ex

# Install OpenTofu version
tenv tofu install

# Tweak git configs
git config --global push.autoSetupRemote true

# Set up GPG if not codespaces
if [ "$CODESPACES" != "true" ]; then
    echo "Running locally, configure gpg."

    git config --global gpg.program gpg2
    git config --global user.signingkey ivanklee86@gmail.com
    git config --global commit.gpgsign true
else
    echo "Running in codespaces."
fi