#!/bin/bash

# Remove the stack                                                                                                                                                                                                                           130 ↵
docker stack rm lab2

# Make the manager leave the swarm (wipes the network database)
docker swarm leave --force

# Kill the DinD workers (the containers causing the routing loops)
docker rm -f $(docker ps -aq -f name=worker)

# Clean all unused networks
docker network prune -f