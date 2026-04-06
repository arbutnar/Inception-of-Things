#!/bin/bash

k3d cluster create arbutnar-cluster \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer" \
    --port "2222:22@loadbalancer" \
    --registry-config /vagrant/confs/registries.yaml