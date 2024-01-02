#!/bin/bash

# Function to get package manager command
getPackageManagerCommand() {
    # Check for Debian-based distributions
    if [[ -f "/etc/debian_version" ]]; then
        dpkg -l
    # Check for Red Hat-based distributions
    elif [[ -f "/etc/redhat-release" ]]; then
        rpm -qa
    # Check for Arch Linux
    elif [[ -f "/etc/arch-release" ]]; then
        pacman -Q
    # Check for SUSE distributions
    elif [[ -f "/etc/SuSE-release" ]]; then
        zypper se --installed-only
    # Check for Gentoo Linux
    elif [[ -f "/etc/gentoo-release" ]]; then
        equery list "*"
    else
        echo "Unsupported distribution or package manager not found."
        return 1
    fi
}

# Call the function
getPackageManagerCommand
