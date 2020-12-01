FROM alpine:latest

RUN apk add --no-cache certbot docker-py

COPY ./etc/periodic/daily/certbot /etc/periodic/daily/certbot

EXPOSE 80/tcp

VOLUME ["/etc/letsencrypt", "/var/lib/letsencrypt", "/var/log/letsencrypt"]

STOPSIGNAL SIGKILL

ENTRYPOINT ["/bin/sh", "-c", "certbot certonly --non-interactive --agree-tos --email $(whoami)@$(hostname) --standalone --deploy-hook /etc/periodic/daily/certbot --cert-name $(hostname) --domain $(hostname) --key-type ecdsa --elliptic-curve secp521r1 \"$@\" && if test $# -eq 0; then exec crond -f; fi", "--"]
