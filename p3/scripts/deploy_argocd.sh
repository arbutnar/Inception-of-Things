#!/bin/bash

HOSTNAME="$1"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=ready pod --all -n argocd --timeout=600s

# k3d loadbalancer will decrypt tls before it reaches argocd ingress. By setting insecure: true we avoid redirection on 443 by argocd-server
kubectl -n argocd patch configmap argocd-cmd-params-cm --type merge -p '{"data":{"server.insecure":"true"}}'
kubectl -n argocd rollout restart deployment argocd-server

kubectl create ingress argocd-server-ingress \
  --namespace=argocd \
  --class=traefik \
  --rule="${HOSTNAME}/*=argocd-server:80"
