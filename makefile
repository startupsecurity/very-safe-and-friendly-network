launch_ssh_basic_password:
	docker build -t ssh-basic-password -f ./boxes/ssh-basic-password/Dockerfile .
	docker run -d --name ssh-basic-password \
	  --cap-add=NET_ADMIN \
	  --cap-add=NET_RAW \
	  --device=/dev/net/tun \
	  -e TAILSCALE_AUTHKEY=${TAILSCALE_AUTHKEY} \
	  -v ./boxes/ssh-basic-password/tailscale-state:/var/lib/tailscale \
	  -e HOSTNAME=ssh-basic-password \
	  -p 22:22 ssh-basic-password
