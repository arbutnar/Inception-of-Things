#!/bin/bash

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n gitlab --timeout=300s

HOSTNAME=gitlab.arbutnar.local
RESET='\e[0m'
CYAN='\e[1;36m'
echo -e "${CYAN}GitLab URL: https://${HOSTNAME}${RESET}"
echo -e "${CYAN}GitLab Username: root${RESET}"

PASSWORD=$(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' 2>/dev/null | base64 --decode)
echo -e "${CYAN}GitLab Password: ${PASSWORD}${RESET}"
