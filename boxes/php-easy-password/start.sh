#!/bin/bash
echo "Starting PHP Easy Password"
echo "Joining Tailscale"
/usr/local/bin/join-tailscale.sh
echo "Starting PHP"
php -S 0.0.0.0:80 -t /var/www/html