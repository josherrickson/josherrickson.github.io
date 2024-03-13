#!/bin/bash

download_and_rename_image() {
    if [ $# -ne 2 ]; then
        echo "Usage: download_and_rename_image <URL> <name>"
        return 1
    fi

    local url="$1"
    local name="$2"

    # Extract filename from URL without query parameters
    local filename=$(basename "$url" | cut -d'?' -f1)

    # Extract file extension
    local extension="${filename##*.}"

    # Calculate hash of downloaded image
    local new_hash=$(curl -sSL "$url" | sha256sum | awk '{print $1}')

    # Check if file already exists
    if [ -f "$name.$extension" ]; then
        # Calculate hash of existing image
        local old_hash=$(sha256sum "$name.$extension" | awk '{print $1}')

        # Compare hashes
        if [ "$new_hash" = "$old_hash" ]; then
            echo "Image $name.$extension already exists and hasn't changed."
            return 0
        else
            echo "Image $name.$extension already exists but has changed."
            echo "Overwriting..."
        fi
    fi

    # Downloading image using curl with follow redirects
    if ! curl -sSL "$url" -o "$name.$extension"; then
        echo "Failed to download image from $url"
        return 1
    fi

    echo "Image downloaded and saved as $name.$extension"
}

download_and_rename_image "https://github.com/josherrickson.png" "github"
download_and_rename_image "https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nc.png" "cc-by-nc"
