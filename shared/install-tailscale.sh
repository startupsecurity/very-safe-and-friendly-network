#!/bin/bash
if ! command -v curl &> /dev/null; then
  echo "Error: curl is not installed."
  exit 1
fi

curl -fsSL https://tailscale.com/install.sh | sh