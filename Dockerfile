FROM ghcr.io/astral-sh/uv:0.5-debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync && unzip frontend.zip -d srv

STOPSIGNAL SIGKILL

CMD caddy start && uv run reflex run --env prod --backend-only