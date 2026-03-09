#!/bin/bash
# 0. Initialize the Swarm
docker swarm init

# Wait for the swarm to be fully initialized
sleep 5

# 1. Get the Join Token                                                                                                                                                                                                                  1 ↵ ✖ ✹ ✭
TOKEN=$(docker swarm join-token -q worker)

# 2. Get your Mac's internal Docker IP (Manager IP)
MANAGER_IP=$(docker info | grep -w 'Node Address' | awk '{print $3}')

# 3. Start a worker container
docker run -d --privileged --name worker-1 --hostname=worker-1 docker:27.3.0-dind

# Wait for the worker to be ready
sleep 5

# 4. Make a worker join the swarm
docker exec -it worker-1 docker swarm join --token $TOKEN $MANAGER_IP:2377