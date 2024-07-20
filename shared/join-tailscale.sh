#!/bin/bash
if [ -z "$TAILSCALE_AUTHKEY" ]; then
  echo "Error: TAILSCALE_AUTHKEY environment variable is not set."
  exit 1
fi

if ! command -v tailscaled &> /dev/null || ! command -v tailscale &> /dev/null; then
  echo "Error: tailscaled and/or tailscale is not installed."
  exit 1
fi

tailscaled --state=/var/lib/tailscale/tailscaled.state &

if ! tailscale status | grep -q "Authentication"; then
    # If not authenticated, then authenticate
    tailscale up --hostname="${HOSTNAME}" --authkey="${TAILSCALE_AUTHKEY}"
else
    echo "Already authenticated to Tailscale"
fi