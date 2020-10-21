#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=himanshuhp/ml-flask-api

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run ml-flask-api --image=$dockerpath:v1 --port=80


# Step 3:
# List kubernetes pods
kubectl get pods

while [ "$(kubectl describe pods ml-flask-api | grep ^Status: | head -1 | awk '{print $2}' | tr -d '\n')" != "Running" ]; do
    echo "Waiting for POD status: $(kubectl describe pods ml-flask-api | grep ^Status: | head -1 | awk '{print $2}' | tr -d '\n')"
done
echo "POD status is Running"

# Step 4:
# Forward the container port to a host
kubectl port-forward ml-flask-api 8000:80

kubectl logs ml-flask-api
