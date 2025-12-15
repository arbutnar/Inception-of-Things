#!/bin/bash

MASTER_URL=gitlab.example.com
HOST_PORT=2443

kubectl wait --for=condition=ready pod --field-selector=status.phase!=Succeeded -n gitlab --timeout=600s
nohup kubectl port-forward -n gitlab svc/gitlab-nginx-ingress-controller ${HOST_PORT}:443 --address 0.0.0.0 > /dev/null 2>&1 &
nohup kubectl port-forward -n gitlab svc/gitlab-gitlab-shell 2222:22 --address 0.0.0.0 > /dev/null 2>&1 &

RESET='\e[0m'
CYAN='\e[1;36m'
echo -e "${CYAN}GitLab URL: https://${MASTER_URL}:${HOST_PORT}${RESET}"
echo -e "${CYAN}GitLab Username: root${RESET}"
echo -e "${CYAN}GitLab Password: $(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' 2>/dev/null | base64 --decode)${RESET}"

# git clone --branch bonus --single-branch https://github.com/arbutnar/iot-p3-arbutnar.git
# cd iot-p3-arbutnar

# sudo cat ~/.ssh/config

# add ssh public on gitlab

# ssh-keygen -R "[192.168.56.113]:2222"

# curl -k 'https://gitlab.example.com:2443/root/iot-p3-arbutnar/-/raw/bonus/application.yaml?ref_type=heads' -o /tmp/application.yaml
# kubectl apply -n argocd -f /tmp/application.yaml

argocd login localhost:1443 --username admin --password $(PASS) --insecure --grpc-web
argocd repo add https://gitlab.example.com:2443/root/iot-p3-arbutnar.git --insecure-skip-server-verification