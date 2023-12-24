#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Installing Docker..."

    # Update package information
    apt-get update

    # Install packages to allow apt to use a repository over HTTPS
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    # Set up the stable repository
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Update package database with Docker packages from the newly added repo
    apt-get update

    # Make sure you are about to install from the Docker repo instead of the default Ubuntu repo
    apt-cache policy docker-ce

    # Install Docker
    apt-get install -y docker-ce

    # Enable and start Docker service
    systemctl start docker
    systemctl enable docker

    echo "Docker installed successfully"
}

# Install Docker
install_docker
