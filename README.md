# Docker What's My IP

A simple IP echo service designed to run behind a Cloudflare proxy. It reads the client's real IP from the `Cf-Connecting-Ip` header and returns it as plain text.

If the header is absent (e.g. direct access not via Cloudflare), the service returns `400 Bad Request`.

## Usage

```sh
docker run -d -p 0.0.0.0:10101:10101 ghcr.io/eingress/whats-my-ip
```

```sh
curl http://0.0.0.0:10101
# 203.0.113.42
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `10101` | Port the service listens on |

## Health check

The image includes a `/health` endpoint that returns `200 OK`, and a built-in `HEALTHCHECK` so container orchestrators can monitor service health.

```sh
curl http://0.0.0.0:10101/health
```

## Traefik

See [traefik/README.md](traefik/README.md) for an example deployment behind Traefik with automatic TLS.
