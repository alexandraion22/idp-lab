#!/bin/bash

echo "Creating Docker volume for GitLab Runner configuration..."
docker volume create gitlab-runner-config

echo "Starting GitLab Runner container..."
docker run -d --name gitlab-runner --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v gitlab-runner-config:/etc/gitlab-runner \
    gitlab/gitlab-runner:latest

echo "Registering GitLab Runner..."
docker run --rm -it -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:latest register

echo "GitLab Runner setup complete!"