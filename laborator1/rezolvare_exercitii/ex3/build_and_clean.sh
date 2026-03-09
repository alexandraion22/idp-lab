#!/bin/bash

# Define variables
IMAGE_NAME="api-laborator-1-image"
NETWORK_NAME="laborator1-db-network"
VOLUME_NAME="laborator1-db-persistent-volume"
DB_CONTAINER="laborator1-db"
API_CONTAINER="laborator1-api"
DB_PORT=5432
API_PORT=5555

# Function to build image, create network & volume
setup() {
    echo "🔄 Building Docker image ($IMAGE_NAME)..."
    docker build -t "$IMAGE_NAME" .

    echo "🔄 Creating network ($NETWORK_NAME) if it does not exists..."
    docker network create -d bridge "$NETWORK_NAME"

    echo "🔄 Creating volume ($VOLUME_NAME) if it does not exists..."
    docker volume create -d local "$VOLUME_NAME"

    echo "✅ Setup complete."
}

# Function to run database and API containers
run() {
    echo "🔄 Starting database container ($DB_CONTAINER)..."
    docker run -d \
        -v "$PWD"/init-db.sql:/docker-entrypoint-initdb.d/init-db.sql \
        -v "$VOLUME_NAME":/var/lib/postgresql/data \
        --network="$NETWORK_NAME" \
        -e POSTGRES_USER=admin \
        -e POSTGRES_PASSWORD=admin \
        -e POSTGRES_DB=books \
        --name "$DB_CONTAINER" \
        postgres:16

    echo "🔄 Starting API container ($API_CONTAINER)..."
    docker run -d \
        --network="$NETWORK_NAME" \
        -e PGUSER=admin \
        -e PGPASSWORD=admin \
        -e PGDATABASE=books \
        -e PGHOST="$DB_CONTAINER" \
        -e PGPORT="$DB_PORT" \
        --name "$API_CONTAINER" \
        -p "$API_PORT":80 \
        "$IMAGE_NAME"

    echo "✅ Containers are running."
}

# Function to stop and remove containers
clean() {
    echo "🛑 Stopping and removing containers..."

    if docker ps -a --format '{{.Names}}' | grep -q "$API_CONTAINER"; then
        docker rm -vf "$API_CONTAINER"
        echo "✅ Removed $API_CONTAINER."
    else
        echo "⚠️ $API_CONTAINER does not exist, skipping."
    fi

    if docker ps -a --format '{{.Names}}' | grep -q "$DB_CONTAINER"; then
        docker rm -vf "$DB_CONTAINER"
        echo "✅ Removed $DB_CONTAINER."
    else
        echo "⚠️ $DB_CONTAINER does not exist, skipping."
    fi
}

full_clean() {
    clean
    echo "🛑 Removing volume ($VOLUME_NAME)..."
    docker volume rm "$VOLUME_NAME" 2>/dev/null && echo "✅ Removed volume." || echo "⚠️ Volume not found."

    echo "🛑 Removing network ($NETWORK_NAME)..."
    docker network rm "$NETWORK_NAME" 2>/dev/null && echo "✅ Removed network." || echo "⚠️ Network not found."

    echo "🛑 Removing Docker image ($IMAGE_NAME)..."
    docker rmi "$IMAGE_NAME" 2>/dev/null && echo "✅ Removed image." || echo "⚠️ Image not found or in use."

    echo "🛑 Removing PostgreSQL image..."
    docker rmi "postgres:16" 2>/dev/null && echo "✅ Removed PostgreSQL image." || echo "⚠️ PostgreSQL image not found or in use."
}

# Main execution flow
case "$1" in
    setup) setup ;;
    run) run ;;
    restart)
        clean
        run
        ;;
    full-clean)
        full_clean
        ;;
    *)
        echo "❌ Invalid option!"
        echo "Usage: $0 {setup|run|restart|full-clean}"
        exit 1
        ;;
esac