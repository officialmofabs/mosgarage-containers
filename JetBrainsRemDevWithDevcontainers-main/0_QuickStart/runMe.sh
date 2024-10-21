#!/bin/bash

# Check if the system is Ubuntu
if ! grep -q "Ubuntu" /etc/os-release; then
    echo "This script is designed for Ubuntu only!"
    echo "Open the .devcontainer/devcontainer.json file in your JetBrains IDE and click on the gutter icon next to the relevant code."
    echo "Run 'Create Dev Container and Mount Sources...'"
    exit 1
fi

# Kernel version
echo "Kernel version:"
uname -r
echo

# Distribution version
echo "Distribution version:"
lsb_release -d | cut -f2-
echo

# System architecture
echo "System architecture:"
uname -m
echo

# List of installed packages
echo "List of installed packages:"
dpkg -l
echo

# General system information
echo "General system information:"
uname -a
echo
