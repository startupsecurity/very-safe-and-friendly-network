FROM php:7.4-cli

# Set working directory
WORKDIR /var/www/html

COPY ./boxes/php-easy-password/src /var/www/html

RUN apt-get update && apt-get install -y curl sudo

COPY shared/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh
RUN /usr/local/bin/install-tailscale.sh

EXPOSE 80

COPY ./boxes/php-easy-password/start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
