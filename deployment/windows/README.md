# Windows Deployment Guide

This guide helps you deploy and run CosmOS on Windows.

## Prerequisites
- [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (Ensure WSL 2 backend is enabled)
- [Git for Windows](https://git-scm.com/download/win)

## Server Setup
1. Open PowerShell or Command Prompt as Administrator.
2. Navigate to the `deployment/server` directory:
   ```powershell
   cd deployment/server
   ```
3. Start the server using Docker Compose:
   ```powershell
   docker compose up -d
   ```
4. Wait for the containers to start. You can check the status with:
   ```powershell
   docker compose ps
   ```

## Client Setup (Electron App)
1. Navigate to the `deployment/electron_app` directory.
2. If you are a developer, run:
   ```powershell
   npm install
   npm start
   ```
3. If you have a pre-built binary, run the `.exe` file provided in the build folder.

## Troubleshooting
- **Docker not running**: Ensure Docker Desktop is started and the whale icon is visible in the system tray.
- **Port Conflict**: If port 80 or 8080 is occupied, edit `compose.yaml` in `deployment/server` to change the port mapping.
