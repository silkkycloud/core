ARG OAUTH2_PROXY_VERSION=7.2.0

####################################################################################################
## Final image
####################################################################################################
FROM alpine:3.15

ARG OAUTH2_PROXY_VERSION

RUN apk add --no-cache \
    ca-certificates \
    tar \
    tini

ADD https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v${OAUTH2_PROXY_VERSION}/oauth2-proxy-v${OAUTH2_PROXY_VERSION}.linux-amd64.tar.gz /tmp/oauth2-proxy-v${OAUTH2_PROXY_VERSION}.linux-amd64.tar.gz
RUN tar xvfz /tmp/oauth2-proxy-v${OAUTH2_PROXY_VERSION}.linux-amd64.tar.gz -C /tmp \
    && cp -r /tmp/oauth2-proxy-v${OAUTH2_PROXY_VERSION}.linux-amd64/oauth2-proxy \
    && rm -rf /tmp/oauth2-proxy-v${OAUTH2_PROXY_VERSION}.linux-amd64.tar.gz \
    && chmod +x /usr/local/bin/oauth2-proxy

# Add an unprivileged user and set directory permissions
RUN adduser --disabled-password --gecos "" --no-create-home oauth2-proxy \
    && chown -R oauth2-proxy:oauth2-proxy /usr/local/bin/oauth2-proxy

USER oauth2-proxy

ENTRYPOINT ["/sbin/tini", "--", "oauth2-proxy"]

EXPOSE 4180

STOPSIGNAL SIGTERM

# Image metadata
LABEL org.opencontainers.image.version=${OAUTH2_PROXY_VERSION}
LABEL org.opencontainers.image.title="OAuth2 Proxy"
LABEL org.opencontainers.image.description="A reverse proxy and static file server that provides authentication using Providers (Google, GitHub, and others) to validate accounts by email, domain or group."
LABEL org.opencontainers.image.vendor="Silkky.Cloud"
LABEL org.opencontainers.image.licenses=Unlicense
LABEL org.opencontainers.image.source="https://github.com/silkkycloud/core"