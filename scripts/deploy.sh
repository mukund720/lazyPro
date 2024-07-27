#!/bin/bash

# Exit on error and print commands
set -ex

# Variables for Hostinger deployment
HOST=$1         # Hostinger hostname or IP
USER=$2         # Hostinger user (e.g., cpanel_username)
SSH_KEY=$3      # Path to the SSH private key for Hostinger access

# Directory on the remote server where files should be uploaded
REMOTE_DIR=/home/$USER/domains/theusalocalnews.com/public_html/cicd	

# Directory of the build artifacts (downloaded by GitHub Actions)
LOCAL_BUILD_DIR=/home/runner/work/lazyPro/lazyPro

# Debug: Print the values of variables
echo "Deploying to Hostinger..."
echo "Host: $HOST"
echo "User: $USER"
echo "Remote Directory: $REMOTE_DIR"
echo "Local Build Directory: $LOCAL_BUILD_DIR"

# Ensure the build artifacts exist
if [ ! -d "$LOCAL_BUILD_DIR" ]; then
  echo "Build directory $LOCAL_BUILD_DIR does not exist. Please check the build process."
  exit 1
fi

# List contents of the build artifacts directory for debugging
echo "Contents of $LOCAL_BUILD_DIR:"
ls -la "$LOCAL_BUILD_DIR"

# Copy build artifacts to the remote server
echo "Copying build artifacts to $USER@$HOST:$REMOTE_DIR..."
scp -i "$SSH_KEY" -r "$LOCAL_BUILD_DIR"/* "$USER@$HOST:$REMOTE_DIR"

echo "Deployment to Hostinger completed successfully."
