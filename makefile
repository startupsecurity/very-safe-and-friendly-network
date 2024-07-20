launch_ssh_basic_password:
	docker build -t ssh-basic-password -f ./boxes/ssh-basic-password/Dockerfile \
	  --build-arg UNSAFE_USERNAME=admin \
	  --build-arg UNSAFE_PASSWORD=password \
	  .

	@if [ $$(docker ps -aq -f name=ssh-basic-password) ]; then \
		docker rm -f ssh-basic-password; \
	fi

	docker run -d --name ssh-basic-password \
	  --cap-add=NET_ADMIN \
	  --cap-add=NET_RAW \
	  --device=/dev/net/tun \
	  -e TAILSCALE_AUTHKEY=${TAILSCALE_AUTHKEY} \
	  -v ./boxes/ssh-basic-password/tailscale-state:/var/lib/tailscale \
	  -e HOSTNAME=ssh-basic-password \
	  -p 22:22 ssh-basic-password

launch_php_easy_password:
	docker build -t php-easy-password -f ./boxes/php-easy-password/Dockerfile .

	@if [ $$(docker ps -aq -f name=php-easy-password) ]; then \
		docker rm -f php-easy-password; \
	fi

	docker run -d --name php-easy-password \
	  --cap-add=NET_ADMIN \
	  --cap-add=NET_RAW \
	  --device=/dev/net/tun \
	  -e TAILSCALE_AUTHKEY=${TAILSCALE_AUTHKEY} \
	  -e SERVICE_USERNAME=admin \
	  -e SERVICE_PASSWORD=password \
	  -v ./boxes/php-easy-password/tailscale-state:/var/lib/tailscale \
	  -e HOSTNAME=php-easy-password \
	  -p 80:80 php-easy-password
