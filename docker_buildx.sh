#!/bin/bash

# Check Docker version
DOCKER_VERSION=$(docker --version)
echo "Docker version: $DOCKER_VERSION"

# Function to enable experimental features on Linux
enable_experimental() {
    echo "Enabling Docker experimental features..."
    if [ ! -f /etc/docker/daemon.json ]; then
        # Create the file if it doesn't exist
        echo '{"experimental": true}' | sudo tee /etc/docker/daemon.json
    else
        # Add "experimental": true to the JSON file
        sudo sed -i 's/{/{\n  "experimental": true,/' /etc/docker/daemon.json
    fi
    sudo systemctl restart docker
    echo "Docker experimental features enabled."
}

# Check if experimental features need to be enabled
read -p "Do you want to enable Docker experimental features? (y/n): " -n 1 -r
echo    # Move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    enable_experimental
fi

# Check if Docker Buildx is installed
if ! docker buildx ls &> /dev/null; then
    echo "Installing Docker Buildx..."

    # Create a new builder instance
    docker buildx create --name mybuilder --use

    # Verify installation
    docker buildx inspect --bootstrap

    echo "Docker Buildx installed."
else
    echo "Docker Buildx is already installed."
fi

echo "Script completed."
