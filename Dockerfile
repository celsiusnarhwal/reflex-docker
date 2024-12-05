FROM ghcr.io/astral-sh/uv:debian

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

WORKDIR /app/

COPY . .

RUN uv sync

ARG API_URL
RUN --mount=type=cache,target=/root/.bun/install/cache API_URL=${API_URL} uv run reflex export --frontend-only --no-zip

STOPSIGNAL SIGKILL

CMD caddy start && uv run reflex run --env prod --backend-only