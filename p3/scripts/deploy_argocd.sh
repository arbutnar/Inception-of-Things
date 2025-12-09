#!/bin/bash

MASTER_IP=$1
HOST_PORT=$2

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=ready pod --all -n argocd --timeout=300s
nohup kubectl port-forward -n argocd svc/argocd-server ${HOST_PORT}:443 --address 0.0.0.0 > /dev/null 2>&1 &

RESET='\e[0m'
PURPLE='\e[1;35m'
echo -e "${PURPLE}ArgoCD URL: https://${MASTER_IP}:${HOST_PORT}${RESET}"
echo -e "${PURPLE}ArgoCD Username: admin${RESET}"
echo -e "${PURPLE}ArgoCD Password: $(kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | grep password | cut -d":" -f2 | tr -d ' ' | base64 -d)${RESET}"