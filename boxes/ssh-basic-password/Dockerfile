FROM ubuntu:latest

ARG UNSAFE_USERNAME
ARG UNSAFE_PASSWORD

ENV UNSAFE_USERNAME=${UNSAFE_USERNAME}
ENV UNSAFE_PASSWORD=${UNSAFE_PASSWORD}

RUN echo "UNSAFE_USERNAME: ${UNSAFE_USERNAME}"
RUN echo "UNSAFE_PASSWORD: ${UNSAFE_PASSWORD}"

RUN apt-get update && apt-get install -y curl openssh-server sudo

COPY shared/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh
RUN /usr/local/bin/install-tailscale.sh

RUN mkdir /var/run/sshd
RUN useradd -rm -d /home/${UNSAFE_USERNAME} -s /bin/bash -G sudo ${UNSAFE_USERNAME}
RUN echo "${UNSAFE_USERNAME}:${UNSAFE_PASSWORD}" | chpasswd

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