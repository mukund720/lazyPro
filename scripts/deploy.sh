#!/bin/bash

# Exit on error
set -e

# Variables for EC2 deployment
EC2_HOST=$1      # EC2 instance hostname or IP
EC2_USER=$2      # EC2 user (e.g., ec2-user or ubuntu)
EC2_SSH_KEY=$3   # Path to the SSH private key for EC2 access

# Build the Docker image if it hasn’t been built already
./build-docker-image.sh

# Log in to Docker Hub using the provided credentials
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Push the Docker image to Docker Hub with the `latest` tag
docker push $DOCKERHUB_USERNAME/scm-pro:latest

# Connect to the EC2 instance and deploy the Docker image
ssh -i "$EC2_SSH_KEY" "$EC2_USER@$EC2_HOST" << 'EOF'
  # Pull the latest Docker image from Docker Hub
  docker pull $DOCKERHUB_USERNAME/scm-pro:latest
  
  # Stop and remove any running container that uses the old image
  docker stop $(docker ps -q --filter ancestor=$DOCKERHUB_USERNAME/scm-pro:latest) || true
  
  # Run a new container with the latest image, mapping port 80
  docker run -d -p 80:80 $DOCKERHUB_USERNAME/scm-pro:latest
EOF
