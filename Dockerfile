FROM ghcr.io/astral-sh/uv:debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync


ARG RAILWAY_SERVICE_ID
ARG API_URL=http://localhost:8080/api
ARG CACHE_DIR=/root/.bun/install/cache
ARG CACHE_ID=s/${RAILWAY_SERVICE_ID}-${CACHE_DIR}
RUN --mount=type=cache,id=${CACHE_ID},target=${CACHE_DIR} API_URL=${API_URL}  \
    uv run reflex export --frontend-only --no-zip

STOPSIGNAL SIGKILL

CMD caddy start && uv run reflex run --env prod --backend-only