#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <hostname> <ip_address>"
    exit 1
}

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Check the number of arguments
if [ $# -ne 2 ]; then
    usage
fi

# Variables
HOSTNAME=$1
IP_ADDRESS=$2
HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.bak"

# Backup the current /etc/hosts file
cp $HOSTS_FILE $BACKUP_FILE
echo "Backup of /etc/hosts created at $BACKUP_FILE"

# Add the new entry
echo "$IP_ADDRESS $HOSTNAME" >> $HOSTS_FILE
echo "New entry added: $IP_ADDRESS $HOSTNAME"

# Verify the entry
if grep -q "$IP_ADDRESS $HOSTNAME" $HOSTS_FILE; then
    echo "Verification successful. The entry has been added to /etc/hosts."
else
    echo "Verification failed. The entry was not added."
fi
