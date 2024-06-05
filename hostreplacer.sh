#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <hostname> <ip_address>"
    exit 1
}

# Check if the script is run as root
# if [ "$(id -u)" -ne 0 ]; then
#     echo "This script must be run as root. Use sudo."
#     exit 1
# fi

# Check the number of arguments
if [ $# -ne 2 ]; then
    usage
fi

# Variables
HOSTNAME="app.cadanapay.com"
IP_ADDRESS=144.217.241.43
HOSTS_FILE="/etc/hosts"

# Add the new entry
echo "$IP_ADDRESS $HOSTNAME" >> $HOSTS_FILE

