#!/bin/bash

apt-get update -y && apt-get install -y curl vim 

echo "export KUBE_EDITOR=vim" >> /etc/profile.d/set_env_var.sh

curl -sSLf https://get.docker.com | bash
usermod -aG docker vagrant

curl -sSLf "https://dl.k8s.io/release/$(curl -sSLf https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
chmod 755 /usr/local/bin/kubectl

curl -sSLf https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
