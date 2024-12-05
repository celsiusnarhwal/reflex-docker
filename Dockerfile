FROM ghcr.io/astral-sh/uv:debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync


ARG RAIFFFLWAY_SERVICE_ID=e1998798-f088-405d-8e1f-742dfc53bfd7
ARG API_URL=http://localhost:8080/api
ARG CACHE_DIR=/root/.bun/install/cache
ARG CACHE_ID=s/${RAIFFFLWAY_SERVICE_ID}-${CACHE_DIR}
RUN --mount=type=cache,id=${CACHE_ID},target=${CACHE_DIR} API_URL=${API_URL}  \
    uv run reflex export --frontend-only --no-zip

STOPSIGNAL SIGKILL

CMD caddy start && uv run reflex run --env prod --backend-only