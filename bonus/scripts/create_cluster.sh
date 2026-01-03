#!/bin/bash

cat > /tmp/registries.yaml <<EOF
mirrors:
  "registry.arbutnar.local":
    endpoint:
      - "http://registry.arbutnar.local"
EOF

k3d cluster create arbutnar-cluster \
    --servers 1 \
    --agents 2 \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer" \
    --port "2222:32022@loadbalancer" \
    --registry-config /tmp/registries.yaml