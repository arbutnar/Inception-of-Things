#!/bin/bash

MASTER_IP=$1
HOST_PORT=1443

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n argocd --timeout=300s
nohup kubectl port-forward -n argocd svc/argocd-server ${HOST_PORT}:443 --address 0.0.0.0 > /dev/null 2>&1 &

RESET='\e[0m'
PURPLE='\e[1;35m'
echo -e "${PURPLE}ArgoCD URL: https://${MASTER_IP}:${HOST_PORT}${RESET}"
echo -e "${PURPLE}ArgoCD Username: admin${RESET}"

ARGO_PASS=$(kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | grep password | cut -d":" -f2 | tr -d ' ' | base64 -d)
echo -e "${PURPLE}ArgoCD Password: ${ARGO_PASS}${RESET}"

if command -v argocd >/dev/null 2>&1; then
    argocd login localhost:${HOST_PORT} --username admin --password ${ARGO_PASS} --insecure
fi

# sudo apt install vim -y
# KUBE_EDITOR="vim" kubectl -n argocd edit configmap argocd-cm
# Comment first apiGroup under resource.exclusions