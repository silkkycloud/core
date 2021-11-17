###################################################################################################
## Builder
####################################################################################################
FROM caddy:2-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/greenpau/caddy-auth-portal \
    --with github.com/greenpau/caddy-authorize 

####################################################################################################
## Final image
####################################################################################################
FROM caddy:2-alpine

# Directory for origin certificates
RUN mkdir -p /tls/

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Copy Caddy configuration
COPY ./Caddy/. /etc/caddy/.

# Use admin endpoint for healthcheck
HEALTHCHECK \
    --start-period=15s \
    --interval=1m \
    --timeout=3s \
    CMD curl --fail http://localhost:2019 || exit 1