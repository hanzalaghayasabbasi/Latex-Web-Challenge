#!/bin/bash

# Directory containing Dockerfile
DOCKERFILE_DIR="/var/www/html/latex"

# Name for the Docker image (lowercase)
IMAGE_NAME="latex"

# Build Docker image
echo "Building Docker image '$IMAGE_NAME'..."
docker build -t $IMAGE_NAME $DOCKERFILE_DIR

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Docker image '$IMAGE_NAME' created successfully."
else
    echo "Failed to create Docker image '$IMAGE_NAME'."
fi

