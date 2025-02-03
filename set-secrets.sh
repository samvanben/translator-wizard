#!/bin/sh

# Path to the secrets file injected by Render (relative path to current directory)
SECRETS_FILE="./secrets.txt"

echo "Checking for secrets file at $SECRETS_FILE..."

# Check if the secrets file exists
if [ -f "$SECRETS_FILE" ]; then
    echo "Secrets file found, reading secrets..."

    # Read the value of the key from the file (assuming it's a single line)
    value=$(cat "$SECRETS_FILE" | xargs)

    # Set the environment variable with the hardcoded key
    echo "Setting VUE_APP_LIBRE_TRANSLATE_API_KEY=$value"
    export VUE_APP_LIBRE_TRANSLATE_API_KEY="$value"
else
    echo "Secrets file not found at $SECRETS_FILE. Make sure Render injects it properly."
    exit 1
fi
