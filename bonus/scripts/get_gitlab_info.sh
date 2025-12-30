#!/bin/bash

MASTER_URL=gitlab.local

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n gitlab --timeout=300s

RESET='\e[0m'
CYAN='\e[1;36m'
echo -e "${CYAN}GitLab URL: https://${MASTER_URL}${RESET}"
echo -e "${CYAN}GitLab Username: root${RESET}"
echo -e "${CYAN}GitLab Password: $(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' 2>/dev/null | base64 --decode)${RESET}"


# ssh-keygen -R "[192.168.56.113]:2222"

# argocd repo add https://gitlab.local:2443/root/iot-p3-arbutnar.git --insecure-skip-server-verification
# curl -kL https://gitlab.local:2443/root/iot-p3-arbutnar/-/raw/main/application.yaml?ref_type=heads > /tmp/application.yaml
# kubectl apply -n argocd -f /tmp/application.yaml

# docker build -t demo-app:v1 -f app/Dockerfile
# push on docker registry