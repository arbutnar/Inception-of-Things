#!/bin/bash

cat > /tmp/registries.yaml <<EOF
configs:
  "registry.arbutnar.local":
    tls:
      insecure_skip_verify: true
EOF

k3d cluster create arbutnar-cluster \
    --servers 1 \
    --agents 2 \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer" \
    --port "2222:22@loadbalancer" \
    --registry-config /tmp/registries.yaml