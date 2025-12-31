#!/bin/bash

curl -fsSL -o /tmp/helm.tar.gz "https://get.helm.sh/helm-v4.0.0-linux-amd64.tar.gz"
tar -xzf /tmp/helm.tar.gz -C /tmp
install -o root -g root -m 0755 /tmp/linux-amd64/helm /usr/local/bin/helm
rm -rf /tmp/helm.tar.gz /tmp/linux-amd64