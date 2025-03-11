#!/bin/bash

# Aducerea in cache-ul local a imaginii busybox din registrul oficial Docker
docker pull busybox

# Rularea unui container de busybox care să execute comanda uptime
docker run busybox uptime

# Rularea unui container interactiv de busybox
docker run -it busybox ash

# Rularea unui container interactiv detașat (daemon) de busybox. Odată ce a pornit, ne atașăm la el.
docker run -d -it --name busybox-test busybox
docker exec -it busybox-test ash

# Ștergerea tuturor containerelor și imaginilor create
docker rm -vf busybox-test
docker rmi -f busybox