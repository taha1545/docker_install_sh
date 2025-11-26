#!/bin/bash

set -e

echo "======================================"
echo "   Installing Docker on Ubuntu..."
echo "======================================"

# Update system
sudo apt update -y

# Install dependencies
sudo apt install -y ca-certificates curl gnupg lsb-release

# Create keyrings directory if not exists
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repo
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt again
sudo apt update -y

# Install Docker Engine
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to docker group
sudo usermod -aG docker $USER

echo "======================================"
echo "Docker installation complete!"
echo "Log out and log back in to use Docker without sudo."
echo "======================================"
