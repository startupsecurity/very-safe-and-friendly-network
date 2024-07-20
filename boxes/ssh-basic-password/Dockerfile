FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl openssh-server sudo

COPY shared/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

RUN /usr/local/bin/install-tailscale.sh

RUN mkdir /var/run/sshd
RUN useradd -rm -d /home/admin -s /bin/bash -G sudo admin
RUN echo 'admin:admin' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

COPY <<EOF /start.sh
#!/bin/bash
/usr/local/bin/join-tailscale.sh
/usr/sbin/sshd -D
EOF

RUN chmod +x /start.sh

CMD ["/start.sh"]