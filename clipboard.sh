#!/bin/bash

# Function to set the clipboard content
set_clipboard() {
    local content="$1"
    echo "$content" | pbcopy
    echo "Clipboard content set."
}

# Function to get the clipboard content
get_clipboard() {
    pbpaste
}

# Display usage
usage() {
    echo "Usage: $0 [get|set <content>]"
    exit 1
}

# Main script logic
if [ $# -lt 1 ]; then
    usage
fi

case "$1" in
    get)
        get_clipboard
        ;;
    set)
        if [ $# -lt 2 ]; then
            echo "Error: No content provided to set."
            usage
        fi
        set_clipboard "$2"
        ;;
    *)
        usage
        ;;
esac

