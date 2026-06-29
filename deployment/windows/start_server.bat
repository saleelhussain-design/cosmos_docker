@echo off
echo Starting CosmOS Server...
cd deployment\server
docker compose up -d
echo Server is starting in the background.
pause
