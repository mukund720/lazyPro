#!/bin/bash

# Exit on error
set -e

# Check if the correct number of arguments is provided
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 <host> <user> <ssh_key> <port> <artifact_url>"
  exit 1
fi

HOST=$1
USER=$2
SSH_KEY=$3
PORT=$4
ARTIFACT_URL=$5

# Temporary directory to store the artifact
TEMP_DIR=$(mktemp -d)

# Download the artifact using wget
echo "Downloading build artifacts..."
wget -O "$TEMP_DIR/build-artifacts.zip" "$ARTIFACT_URL"

# Unzip the artifact
echo "Unzipping build artifacts..."
unzip "$TEMP_DIR/build-artifacts.zip" -d "$TEMP_DIR"

# Deploy the application (modify the following commands based on your deployment process)
echo "Deploying application..."
rsync -avz --delete "$TEMP_DIR/lazy-pro/" "$USER@$HOST:/home/$USER/domains/theusalocalnews.com/public_html/cicd"

# Cleanup
rm -rf "$TEMP_DIR"

echo "Deployment complete."
