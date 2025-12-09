#!/bin/bash

apt-get update -y && apt-get install -y curl

curl -sSLf https://get.docker.com | bash
usermod -aG docker vagrant

curl -sSLf "https://dl.k8s.io/release/$(curl -sSLf https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -sSLf https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

k3d cluster create arbutnarS

mkdir -p /home/vagrant/.kube
k3d kubeconfig get arbutnarS > /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 700 /home/vagrant/.kube/config