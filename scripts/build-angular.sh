#!/bin/bash

# Exit on error
set -e

# Navigate to the project directory (one level up from this script's location)
cd "$(dirname "$0")/.."

# Install dependencies listed in package.json
npm install

# Run tests (commented out; uncomment if you want to run tests before build)
# npm test

# Build the Angular application for production
npm run build --prod
