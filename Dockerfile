FROM ghcr.io/astral-sh/uv:debian

ENV REDIS_URL="redis://localhost"
ENV REFLEX_BACKEND_ONLY=true

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy
COPY --from=redis /usr/local/bin/redis-server /usr/bin/redis-server

WORKDIR /app/

COPY . .

RUN uv sync

RUN #uv run reflex export --frontend-only --no-zip

CMD caddy start && redis-server --daemonize yes && uv run reflex run --env prod