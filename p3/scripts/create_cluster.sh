#!/bin/bash

k3d cluster create arbutnar-cluster \
  --port "80:80@loadbalancer" \
  --port "443:443@loadbalancer" \
  --k3s-arg "--disable=traefik@server:*"
