# homelab 🏠

Docker Compose stacks and notes for my self-hosted setup: a Proxmox node running a Debian VM as Docker host,
fronted by Nginx Proxy Manager and reachable from outside only through Tailscale / Cloudflare Tunnel.

```
                 ┌──────────── Proxmox VE ─────────────┐
 Internet ──▶ Cloudflare Tunnel ──▶ ┌─ Debian VM (Docker) ─────────────┐
 Tailnet  ──────────────────────────▶│ nginx-proxy-manager :80/:443     │
                                     │  ├─ homepage        (dashboard)  │
                                     │  ├─ uptime-kuma     (monitoring) │
                                     │  ├─ grafana + prometheus + node  │
                                     │  └─ ollama + open-webui (LLMs)   │
                                     └──────────────────────────────────┘
```

## Stacks

| Stack | Services | Notes |
|---|---|---|
| [`stacks/proxy`](stacks/proxy) | Nginx Proxy Manager | TLS via Let's Encrypt DNS challenge (Cloudflare) |
| [`stacks/dashboard`](stacks/dashboard) | Homepage | Single landing page for every service |
| [`stacks/monitoring`](stacks/monitoring) | Uptime Kuma, Prometheus, node-exporter, Grafana | Alerts to Telegram |
| [`stacks/ai`](stacks/ai) | Ollama, Open WebUI | Local LLMs (Llama, Mistral, DeepSeek-R1 distills) |

All stacks share an external Docker network called `proxy`, so NPM can reach every container by name.

## Quick start

```bash
docker network create proxy
cp .env.example .env            # fill in your values
make up STACK=proxy
make up STACK=dashboard
make up STACK=monitoring
make up STACK=ai
```

`make ps`, `make logs STACK=ai`, `make pull` and `make down STACK=...` do what you'd expect.

## Docs

- [`docs/proxmox.md`](docs/proxmox.md) — VM sizing, storage layout, backups
- [`docs/hardening.md`](docs/hardening.md) — SSH, firewall, unattended upgrades, Tailscale ACLs

## License

MIT
