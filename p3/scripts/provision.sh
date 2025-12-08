#!/bin/bash

RESET='\033[0m'
PURPLE='\033[0;35m'
apt-get update -y && apt-get upgrade -y && apt-get install -y curl

# Install Docker (required for k3d)
curl -sSLf https://get.docker.com | bash
usermod -aG docker vagrant

# Install kubectl
curl -sSLf "https://dl.k8s.io/release/$(curl -sSLf https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install k3d
curl -sSLf https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# # Create cluster with k3d with port mappings
# # Map ports 8080-8090 on VM to cluster for services
k3d cluster create arbutnarS
#   -p "8080:80@loadbalancer" \
#   -p "8443:443@loadbalancer"

# Make the k3d kubeconfig available to the vagrant user
mkdir -p /home/vagrant/.kube
k3d kubeconfig get arbutnarS > /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 700 /home/vagrant/.kube/config

# Deploy argocd in argocd namespace
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl wait --for=condition=ready pod --all -n argocd --timeout=300s

# # Print argocd server password
# echo -e "$PURPLE$(kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | grep password | cut -d":" -f2 | tr -d ' ' | base64 -d)$RESET"