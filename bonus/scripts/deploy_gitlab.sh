#!/bin/bash

# helm repo add gitlab http://charts.gitlab.io/
# helm repo update
# kubectl create namespace gitlab

# helm upgrade --install gitlab gitlab/gitlab -n gitlab \
#     --version 9.6.1 \
#     --set global.ingress.tls.enabled=false \
#     --set global.hosts.https=false \
#     --set installCertmanager=false \
#     --set global.ingress.configureCertmanager=false \
#     --set global.kas.enabled=false \
#     --set prometheus.install=false \
#     --set postgresql.metrics.enabled=false \
#     --set redis.metrics.enabled=false \
#     --set gitlab.gitlab-exporter.enabled=false \
#     --set global.grafana.enabled=false \
#     --set gitlab.gitlab-pages.enabled=false \
#     --set gitlab.webservice.minReplicas=1 \
#     --set gitlab.webservice.maxReplicas=1 \
#     --set gitlab.sidekiq.minReplicas=1 \
#     --set gitlab.sidekiq.maxReplicas=1 \
#     --set gitlab.gitlab-shell.minReplicas=1 \
#     --set gitlab.gitlab-shell.maxReplicas=1 \
#     --set registry.hpa.minReplicas=1 \
#     --set registry.hpa.maxReplicas=1 \
#     --set nginx-ingress.controller.replicaCount=1 \
#     --set nginx-ingress.controller.service.type=NodePort \
#     --set gitlab.gitlab-shell.service.type=NodePort \
#     --set nginx-ingress.controller.service.nodePorts.http=30080 \
#     --set nginx-ingress.controller.service.nodePorts.https=30443 \
#     --set gitlab.gitlab-shell.service.nodePort=30022 \
#     --set global.hosts.domain=local \
#     --set global.hosts.gitlab.name=gitlab.local \
#     --wait --timeout 1200s

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install gitlab gitlab/gitlab \
    --version 9.7.0 \
    -f /vagrant/confs/values.yaml \
    --namespace gitlab \
    --create-namespace \
    --wait \
    --timeout 900s
