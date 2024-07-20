#!/bin/bash

if [[ -z "$TAILSCALE_AUTHKEY" ]]; then
  echo "Error: TAILSCALE_AUTHKEY environment variable is not set."
  exit 1
fi

if [[ -z "$HOSTNAME" ]]; then
  echo "Error: HOSTNAME environment variable is not set."
  exit 1
fi

export TAILSCALE_SOCKET="/var/run/tailscale/tailscaled_${HOSTNAME}.sock"

if ! command -v tailscaled &> /dev/null || ! command -v tailscale &> /dev/null; then
  echo "Error: tailscaled and/or tailscale is not installed."
  exit 1
fi

tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=${TAILSCALE_SOCKET} &

# Wait for the socket to be created
for i in {1..10}; do
  if [ -S "${TAILSCALE_SOCKET}" ]; then
    break
  fi
  echo "Waiting for tailscaled socket to be created...${i}/10"
  sleep 1
done

if [ ! -S "${TAILSCALE_SOCKET}" ]; then
  echo "Error: Tailscaled socket was not created."
  exit 1
fi

if ! tailscale --socket=${TAILSCALE_SOCKET} status | grep -q "Authentication"; then
    # If not authenticated, then authenticate
    tailscale --socket=${TAILSCALE_SOCKET} up --hostname="${HOSTNAME}" --authkey="${TAILSCALE_AUTHKEY}"
else
    echo "Already authenticated to Tailscale"
fi

if ! tailscale --socket=${TAILSCALE_SOCKET} status | grep -q "Logged in as"; then
  echo "Error: Failed to log in to Tailscale."
  exit 1
fi