#!/bin/bash

k3d cluster create arbutnar-cluster \
    --servers 1 \
    --agents 2 \
    --port "443:443@loadbalancer" \
    --port "80:80@loadbalancer"
