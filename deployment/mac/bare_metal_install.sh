#!/bin/bash
echo "Starting Bare Metal Installation for CosmOS on macOS..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing dependencies..."
brew install python node mariadb redis

echo "Installing Frappe Bench..."
pip3 install frappe-bench

echo "Bare metal dependencies installed. Please follow the manual setup for site initialization."
