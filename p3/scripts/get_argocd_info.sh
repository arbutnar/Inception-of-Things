#!/bin/bash

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n argocd --timeout=300s

RESET='\e[0m'
PURPLE='\e[1;35m'
echo -e "${PURPLE}ArgoCD URL: https://argocd.local${RESET}"
echo -e "${PURPLE}ArgoCD Username: admin${RESET}"

ARGO_PASS=$(kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | grep password | cut -d":" -f2 | tr -d ' ' | base64 -d)
echo -e "${PURPLE}ArgoCD Password: ${ARGO_PASS}${RESET}"
