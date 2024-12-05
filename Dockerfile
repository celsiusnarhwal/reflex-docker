FROM ghcr.io/astral-sh/uv:debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync

RUN uv run reflex export --frontend-only --no-zip

CMD caddy start && uv run reflex run --env prod --backend-only