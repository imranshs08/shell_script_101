#!/bin/bash

echo "Script to Install Git"
echo "Installation Started"

OS_TYPE=$(uname)

if [ "$OS_TYPE" = "Linux" ]; then
    echo "Detected Linux..."
    # Check for apt (Debian/Ubuntu)
    if command -v apt >/dev/null; then
        echo "Installing with apt..."
        sudo apt update
        sudo apt install git -y
    # Check for yum (RHEL/CentOS)
    elif command -v yum >/dev/null; then
        echo "Installing with yum..."
        sudo yum install git -y
    else
        echo "No supported package manager found (apt/yum)."
    fi

elif [ "$OS_TYPE" = "Darwin" ]; then
    echo "Detected Mac..."
    brew install git

# Check for Windows (MINGW/MSYS/CYGWIN) using wildcard matching
elif [[ "$OS_TYPE" == *"MINGW"* ]] || [[ "$OS_TYPE" == *"CYGWIN"* ]] || [[ "$OS_TYPE" == *"MSYS"* ]]; then
    echo "Detected Windows..."
    
    if command -v git >/dev/null; then
        echo "Git is already installed! ($(git --version))"
        echo "If you want to update it, run 'winget upgrade Git.Git'"
    else
        echo "Installing Git via Winget..."
        winget install --id Git.Git -e --source winget
    fi

else
    echo "Unknown OS System: $OS_TYPE"
fi