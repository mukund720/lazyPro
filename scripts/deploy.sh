#!/bin/bash

# Exit on error
set -e

# Variables for Hostinger deployment
HOST=$1         # Hostinger hostname or IP
USER=$2         # Hostinger user (e.g., cpanel_username)
SSH_KEY=$3     # SSH_KEY for Hostinger access
PORT=$4         # Port number for SSH

# Directory on the remote server where files should be uploaded
REMOTE_DIR=/home/$USER/domains/theusalocalnews.com/public_html/cicd

# Directory of the build artifacts
LOCAL_BUILD_DIR=dist/lazy-pro

# Print directory contents
echo "Contents of the build directory:"
ls -la "$LOCAL_BUILD_DIR"

echo "Contents of the parent directory:"
ls -la $(dirname "$LOCAL_BUILD_DIR")


# Print debug information
echo "Deploying to Hostinger..."
echo "Host: $HOST"
echo "User: $USER"
echo "Port: $PORT"
echo "Remote Directory: $REMOTE_DIR"
echo "Local Build Directory: $LOCAL_BUILD_DIR"

# Ensure the build is complete before deployment
if [ ! -d "$LOCAL_BUILD_DIR" ]; then
  echo "Build directory $LOCAL_BUILD_DIR does not exist. Please check the build process."
  exit 1
fi

# Copy build artifacts to the remote server using scp
scp -P "$PORT" -r "$LOCAL_BUILD_DIR"/* "$USER@$HOST:$REMOTE_DIR"

# Optional: Add commands to restart services or perform other tasks if necessary
# Example: Restarting Apache or Nginx on Hostinger (if applicable)
# ssh -p "$PORT" "$USER@$HOST" "sudo systemctl restart apache2"  # For Apache
# ssh -p "$PORT" "$USER@$HOST" "sudo systemctl restart nginx"   # For Nginx
