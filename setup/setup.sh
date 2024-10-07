#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
        
# Function to print messages in colored format
info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

error() {
    echo -e "\e[31m[ERROR]\e[0m $1"
    exit 1
}

# Check the OS type
info "Detecting OS type..."
if [ -f /etc/debian_version ]; then
    OS="debian"
    PACKAGE_MANAGER="apt"
    INSTALL_CMD="sudo $PACKAGE_MANAGER install -y"
    UPDATE_CMD="sudo $PACKAGE_MANAGER update -y"
elif [ -f /etc/arch-release ]; then
    OS="arch"
    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="sudo $PACKAGE_MANAGER -S --noconfirm"
    UPDATE_CMD="sudo $PACKAGE_MANAGER -Syu"
elif [ -f /etc/redhat-release ]; then
    OS="rhel"
    PACKAGE_MANAGER="yum"
    INSTALL_CMD="sudo $PACKAGE_MANAGER install -y"
    UPDATE_CMD="sudo $PACKAGE_MANAGER update -y"
else
    error "Unsupported OS. Please use Debian-based, Arch-based, or RHEL-based OS."
fi

info "OS detected: $OS"

# Update package manager
info "Updating package manager..."
$UPDATE_CMD || error "Package manager update failed."


# Check if git is installed
if ! command -v git &> /dev/null; then
    info "Git not found. Installing git..."
    $INSTALL_CMD git || error "Failed to install git."
else
    info "Git is already installed."
fi

# Clone the repository
REPO_URL="https://github.com/yagyandatta/prometheus-grafana-monitoring-alerting.git"
CLONE_DIR="prometheus-grafana-monitoring-alerting"

# Check if the directory already exists
if [ -d "$CLONE_DIR" ]; then
    info "Directory $CLONE_DIR already exists. Removing it to clone a fresh copy..."
    rm -rf $CLONE_DIR
fi

info "Cloning repository from $REPO_URL..."
git clone $REPO_URL || error "Failed to clone the repository."

# Navigate into the cloned directory
cd $CLONE_DIR

# Run docker-compose up command
info "Starting services with docker-compose..."
sudo docker-compose up -d || error "Failed to start services with docker-compose."

# Show the running containers from docker-compose
info "Listing running services..."
sudo docker-compose ps  

# Show all running Docker containers
info "Listing all running containers..."
sudo docker ps

# Success message and access URLs
echo -e "\e[32m[SUCCESS]\e[0m Setup completed successfully!"
echo -e "\e[34m[INFO]\e[0m Prometheus access URL: \e[33mhttp://localhost:9100\e[0m or \e[33mhttp://<your-ip>:9100\e[0m"
echo -e "\e[34m[INFO]\e[0m Grafana access URL: \e[33mhttp://localhost:3000\e[0m or \e[33mhttp://<your-ip>:3000\e[0m"
echo -e "\e[34m[INFO]\e[0m You can check logs using: \e[33mdocker-compose logs -f\e[0m"
echo -e "\e[34m[INFO]\e[0m To view individual container logs: \e[33mdocker logs <container_id>\e[0m"