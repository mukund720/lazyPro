#!/bin/bash

# Exit on error
set -e

# Variables for Hostinger deployment
HOST=$1         # Hostinger hostname or IP
USER=$2         # Hostinger user (e.g., cpanel_username)
SSH_KEY=$3      # Path to the SSH private key for Hostinger access

# Directory on the remote server where files should be uploaded
REMOTE_DIR=/home/$USER/domains/theusalocalnews.com/public_html/	

# Directory of the build artifacts
LOCAL_BUILD_DIR=dist/lazy-pro

# Ensure the build is complete before deployment
if [ ! -d "$LOCAL_BUILD_DIR" ]; then
  echo "Build directory $LOCAL_BUILD_DIR does not exist. Please build the project first."
  exit 1
fi

# Copy build artifacts to the remote server
scp -i "$SSH_KEY" -r "$LOCAL_BUILD_DIR"/* "$USER@$HOST:$REMOTE_DIR"

# Optional: Add commands to restart services or perform other tasks if necessary
# Example: Restarting Apache or Nginx on Hostinger (if applicable)
# ssh -i "$SSH_KEY" "$USER@$HOST" "sudo systemctl restart apache2"  # For Apache
# ssh -i "$SSH_KEY" "$USER@$HOST" "sudo systemctl restart nginx"   # For Nginx
