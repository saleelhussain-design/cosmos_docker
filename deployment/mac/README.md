# macOS Deployment Guide

This guide helps you deploy and run CosmOS on macOS.

## Prerequisites
- [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/)
- [Homebrew](https://brew.sh/) (Optional, for easier package management)

## Server Setup
1. Open Terminal.
2. Navigate to the `deployment/server` directory:
   ```bash
   cd deployment/server
   ```
3. Start the server using Docker Compose:
   ```bash
   docker compose up -d
   ```
4. Check the status of the containers:
   ```bash
   docker compose ps
   ```

## Client Setup (Electron App)
1. Navigate to the `deployment/client` directory.
2. Run the installation script:
   ```bash
   chmod +x install_client.sh
   ./install_client.sh
   ```
3. Launch the application using:
   ```bash
   chmod +x launch_cosmos.command
   ./launch_cosmos.command
   ```

## Troubleshooting
- **Permission Denied**: Use `chmod +x` to make scripts executable.
- **Docker Issues**: Ensure Docker Desktop is running and updated to the latest version.
