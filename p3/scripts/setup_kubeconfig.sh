#!/bin/bash

mkdir -p /home/vagrant/.kube
k3d kubeconfig get arbutnar-cluster > /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 700 /home/vagrant/.kube/config
