#!/bin/bash

# this runs as part of pre-build

echo "on-create start"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create start" >> "$HOME/status"

# Get the list of all existing clusters
clusters=$(k3d cluster list -o json | jq -r '.[].name')

# Iterate over each cluster and delete it
for cluster in $clusters; do
  echo "Deleting cluster $cluster"
  k3d cluster delete $cluster
done


# Create a new cluster with the given configuration
k3d cluster create --config .devcontainer/infra/k8s/k3d/config.yaml

echo "on-create complete"
echo "$(date +'%Y-%m-%d %H:%M:%S')    on-create complete" >> "$HOME/status"