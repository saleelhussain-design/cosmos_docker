#!/bin/bash
echo "Starting CosmOS Server..."
cd "$(dirname "$0")/server"
docker compose up -d
echo "Server is starting in the background."
