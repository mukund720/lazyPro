#!/bin/bash

# Exit on error
set -e

# Navigate to the project directory (one level up from this script's location)
cd "$(dirname "$0")/.."

# Install dependencies listed in package.json
echo "Installing dependencies..."
npm install

# Run tests (commented out; uncomment if you want to run tests before build)
# echo "Running tests..."
# npm test

# Build the Angular application for production
echo "Building Angular application..."
npm run build --prod

# Verify that the build artifacts were created
echo "Verifying build artifacts..."
ls -la dist
echo "dir list"
ls -la
