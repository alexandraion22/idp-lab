#!/bin/bash

# Build
docker build -t node.jstest .

# Run
docker container run -d -p 12345:8080 --name node_test node.jstest