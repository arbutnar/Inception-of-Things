#!/bin/bash

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n argocd --timeout=300s

HOSTNAME=argocd.arbutnar.local
RESET='\e[0m'
PURPLE='\e[1;35m'
echo -e "${PURPLE}ArgoCD URL: https://${HOSTNAME}${RESET}"
echo -e "${PURPLE}ArgoCD Username: admin${RESET}"

PASS=$(kubectl get secret -n argocd argocd-initial-admin-secret -oyaml | grep password | cut -d":" -f2 | tr -d ' ' | base64 -d)
echo -e "${PURPLE}ArgoCD Password: ${PASS}${RESET}"
