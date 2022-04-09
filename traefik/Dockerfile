ARG TRAEFIK_VERSION=2.6.3

####################################################################################################
## Final image
####################################################################################################
FROM alpine:3.15

ARG TRAEFIK_VERSION

RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    tar \
    tini

ADD https://github.com/traefik/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_linux_amd64.tar.gz /tmp/traefik.tar.gz
RUN tar xvfz /tmp/traefik.tar.gz -C /usr/local/bin traefik; \
    rm -rf /tmp/traefik.tar.gz; \
    chmod +x /usr/local/bin/traefik

# Add an unprivileged user and set directory permissions
RUN adduser --disabled-password --gecos "" --no-create-home traefik \
    && chown -R traefik:traefik /usr/local/bin/traefik

USER traefik

ENTRYPOINT ["/sbin/tini", "--", "traefik"]

# NET_BIND_SERVICE permissions are required for this container
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

# Image metadata
LABEL org.opencontainers.image.version=${TRAEFIK_VERSION}
LABEL org.opencontainers.image.title=Traefik
LABEL org.opencontainers.image.description="Traefik is a modern HTTP reverse proxy and load balancer."
LABEL org.opencontainers.image.vendor="Silkky.Cloud"
LABEL org.opencontainers.image.licenses=Unlicense
LABEL org.opencontainers.image.source="https://github.com/silkkycloud/core"