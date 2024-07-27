#!/bin/bash

# Exit on error
set -e

# Navigate to the project directory (one level up from this script's location)
cd "$(dirname "$0")/.."

# Build the Docker image and tag it with the repository and latest tag
docker build -t $DOCKERHUB_USERNAME/lazy-pro:latest .

# Verify the image exists locally by listing Docker images and filtering for the image name
docker images | grep $DOCKERHUB_USERNAME/lazy-pro
