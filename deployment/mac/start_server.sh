#!/bin/bash
echo "Starting CosmOS Server..."
cd "$(dirname "$0")/server" || exit
docker compose up -d
echo "Server is starting in the background."
