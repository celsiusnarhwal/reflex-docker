FROM ghcr.io/astral-sh/uv:0.5-debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync

STOPSIGNAL SIGKILL

CMD ls .web/_static && caddy start && uv run reflex run --env prod --backend-only