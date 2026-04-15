#!/bin/bash

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm install gitlab gitlab/gitlab \
    --version 9.7.0 \
    -f /vagrant/confs/values.yaml \
    --namespace gitlab \
    --create-namespace \
    --wait \
    --timeout 900s
