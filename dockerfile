# =============================================================================
# Multi-stage build for air-gapped Docsify container
# =============================================================================

# ---------------------------------------------------------------------------
# Stage 1: builder — download and bundle all assets
# ---------------------------------------------------------------------------
FROM node:24-alpine AS builder

RUN apk add --no-cache curl wget jq

COPY customize.sh /tmp/custom_scripts/
RUN sh /tmp/custom_scripts/customize.sh

# ---------------------------------------------------------------------------
# Stage 2: runtime — minimal image with docsify-cli and bundled assets
# ---------------------------------------------------------------------------
FROM node:24-alpine

LABEL description="Docsify air-gapped"
WORKDIR /docs

RUN apk add --no-cache tini
RUN npm install -g docsify-cli@4.4.4

# Copy bundled assets from builder
COPY --from=builder /tmp/.docsify /tmp/.docsify

# Entrypoint copies assets into /docs at startup then serves
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3000/tcp
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["entrypoint.sh"]
