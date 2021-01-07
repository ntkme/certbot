FROM alpine:latest

RUN apk add --no-cache certbot docker-py openssh-client

COPY ./etc/periodic/daily/certbot /etc/periodic/daily/certbot

EXPOSE 80/tcp

VOLUME ["/etc/letsencrypt", "/var/lib/letsencrypt", "/var/log/letsencrypt"]

STOPSIGNAL SIGKILL

ENTRYPOINT ["/bin/sh", "-c", "certbot certonly --non-interactive --agree-tos --email $(whoami)@$(hostname) --standalone --deploy-hook /etc/periodic/daily/certbot --cert-name $(hostname) --domain $(hostname) \"$@\" && exec crond -f", "--"]
