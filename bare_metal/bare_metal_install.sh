#!/bin/bash
echo "Starting Bare Metal Installation for CosmOS..."

# Update system
sudo apt-get update -y
sudo apt-get install -y git python3-dev python3-pip python3-venv mariadb-server redis-server curl nodejs npm

echo "Installing Frappe Bench..."
pip3 install --user frappe-bench

echo "Bare metal dependencies installed. Please follow the manual setup for site initialization."
