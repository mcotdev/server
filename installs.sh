#!/bin/bash
# Python
sudo apt install python3 python3-pip

# Install various help programs
sudo apt install git mc fzf micro neovim

# Go 
# Get the architecture of the current system
ARCH=$(uname -m)

# Map the architecture to the corresponding value used in Go's download URL
case $ARCH in
    "x86_64")
        ARCH="amd64"
        ;;
    "aarch64")
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Retrieve the latest version of Go for the current architecture
LATEST_VERSION=$(curl -s https://golang.org/dl/ | grep -oP "go[0-9]+\.[0-9]+\.[0-9]+.linux-$ARCH.tar.gz" | head -n 1)

# Extract the version number from the download URL
VERSION=$(echo $LATEST_VERSION | grep -oP "go[0-9]+\.[0-9]+\.[0-9]+")

# Download the latest Go release
echo "Downloading Go $VERSION for $ARCH..."
curl -O https://golang.org/dl/$LATEST_VERSION

# Extract the Go release
echo "Extracting..."
tar -xvf $LATEST_VERSION

# Set the Go environment variables
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

# Clean up the downloaded archive
rm $LATEST_VERSION

echo "Go $VERSION has been installed successfully!"

# Rust
curl https://sh.rustup.rs -sSf | sh

