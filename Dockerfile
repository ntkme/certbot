FROM docker.io/library/alpine:3.15.0

RUN apk add --no-cache certbot docker-py openssh-client

COPY ./etc/periodic/daily/certbot /etc/periodic/daily/certbot

EXPOSE 80/tcp

VOLUME ["/etc/letsencrypt", "/var/lib/letsencrypt", "/var/log/letsencrypt"]

STOPSIGNAL SIGKILL

ENTRYPOINT ["/bin/sh", "-c", "certbot certonly --non-interactive --agree-tos --register-unsafely-without-email --standalone --deploy-hook /etc/periodic/daily/certbot --key-type ecdsa --domain \"$(hostname)\" \"$@\" || test -f \"/etc/letsencrypt/renewal/$(hostname).conf\" && exec crond -f", "--"]
