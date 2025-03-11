#!/bin/bash

CONTAINER_NAME="node_test"
IMAGE_NAME="node.jstest"
PORT_MAPPING="12345:8080"

# Function to clean up the Docker container and image
clean() {
    echo "🔄 Stopping and removing container ($CONTAINER_NAME)..."
    if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
        docker rm -vf "$CONTAINER_NAME"
        echo "✅ Container removed."
    else
        echo "⚠️ Container does not exist, skipping removal."
    fi

    echo "🔄 Removing image ($IMAGE_NAME)..."
    IMAGE_ID=$(docker images -q "$IMAGE_NAME")

    if [[ -n "$IMAGE_ID" ]]; then
        docker image rm "$IMAGE_ID"
        echo "✅ Image removed."
    else
        echo "⚠️ Image does not exist, skipping removal."
    fi
}

# Function to build and run the Docker container
run() {
    echo "🔄 Building Docker image ($IMAGE_NAME)..."
    docker build -t "$IMAGE_NAME" .
    echo "✅ Build completed."

    echo "🔄 Checking if container ($CONTAINER_NAME) already exists..."
    if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
        echo "⚠️ Container ($CONTAINER_NAME) already exists. Removing it..."
        docker rm -vf "$CONTAINER_NAME"
        echo "✅ Removed existing container."
    fi

    echo "🔄 Running container ($CONTAINER_NAME)..."
    docker container run -d -p "$PORT_MAPPING" --name "$CONTAINER_NAME" "$IMAGE_NAME"
    echo "✅ Container is running at http://localhost:${PORT_MAPPING%%:*}"
}

# Argument handling
case "$1" in
    clean) clean ;;
    run) run ;;
    *)
        echo "❌ Invalid option!"
        echo "Usage: $0 [clean|run]"
        echo "  clean - Clean up container and image"
        echo "  run - Build and run the container"
        exit 1
        ;;
esac
