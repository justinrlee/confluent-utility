#!/bin/bash

set -e
set -x

export PACKAGE_DIR=build

mkdir -p ${PACKAGE_DIR}
cd ${PACKAGE_DIR}

# https://github.com/mikefarah/yq/releases
curl -LO https://github.com/mikefarah/yq/releases/download/v4.47.1/yq_linux_amd64
curl -LO https://github.com/mikefarah/yq/releases/download/v4.47.1/yq_linux_arm64

# https://docs.confluent.io/platform/current/installation/installing_cp/zip-tar.html
curl -O https://packages.confluent.io/archive/8.0/confluent-8.0.0.tar.gz

# https://docs.confluent.io/confluent-cli/current/install.html#tarball-or-zip-installation
curl -O https://packages.confluent.io/confluent-cli/archives/latest/confluent_linux_amd64.tar.gz
curl -O https://packages.confluent.io/confluent-cli/archives/latest/confluent_linux_arm64.tar.gz

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl -O "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
curl -O "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" -o kubectl-arm64
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl-amd64

# https://developer.hashicorp.com/vault/install#linux (Binary Download)
curl -LO https://releases.hashicorp.com/vault/1.20.2/vault_1.20.2_linux_amd64.zip
curl -LO https://releases.hashicorp.com/vault/1.20.2/vault_1.20.2_linux_arm64.zip