#!/bin/bash

HOSTNAME="$1"

kubectl create namespace argocd
kubectl apply --server-side -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=ready pod --all -n argocd --timeout=600s

kubectl create ingress argocd-server-ingress \
  --namespace=argocd \
  --class=nginx \
  --annotation="nginx.ingress.kubernetes.io/ssl-passthrough=true" \
  --annotation="nginx.ingress.kubernetes.io/backend-protocol=HTTPS" \
  --rule="${HOSTNAME}/*=argocd-server:443"
