#!/bin/bash

echo "Running docker-compose down"
docker-compose down

echo "Stopping homeassistant"
docker stop homeassistant

echo "Stopping other hassio containers (like dns)"
docker ps | grep " hassio_" | cut -f 1 -d ' ' | xargs docker stop

echo "Stopping addon containters"
docker ps | grep " addon_" | cut -f 1 -d ' ' | xargs docker stop
