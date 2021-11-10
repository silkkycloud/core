###################################################################################################
## Builder
####################################################################################################
FROM caddy:2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/greenpau/caddy-auth-portal \
    --with github.com/greenpau/caddy-authorize \
    --with github.com/mastercactapus/caddy-proxyprotocol

####################################################################################################
## Final image
####################################################################################################
FROM caddy:2-alpine

# Directory for origin certificates
RUN mkdir -p /tls/

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY ./Caddy/. /etc/caddy/.
