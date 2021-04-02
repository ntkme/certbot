# container-certbot

``` sh
docker run -d \
  --hostname $(hostname -f) \
  --publish 80:80/tcp \
  --volume /etc/letsencrypt:/etc/letsencrypt \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  ghcr.io/ntkme/certbot
```

``` sh
podman system service -t 0 &

podman run -d \
  --hostname $(hostname -f) \
  --publish 80:80/tcp \
  --volume /etc/letsencrypt:/etc/letsencrypt \
  --volume /var/run/podman/podman.sock:/var/run/docker.sock \
  ghcr.io/ntkme/certbot
```
