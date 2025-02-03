#!/bin/bash

# Path to the secrets file injected by Render
SECRETS_FILE="/etc/secrets/secrets.txt"

# Check if the secrets file exists
if [ -f "$SECRETS_FILE" ]; then
    echo "Secrets file found, reading secrets..."

    # Loop through the secrets.txt file and set them as environment variables
    while IFS='=' read -r key value; do
        # Skip empty lines and comments
        if [[ ! -z "$key" && ! "$key" =~ ^# ]]; then
            echo "Setting $key"
            export "$key=$value"
        fi
    done < "$SECRETS_FILE"
else
    echo "Secrets file not found at $SECRETS_FILE. Make sure Render injects it properly."
    exit 1
fi
