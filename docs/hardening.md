# Hardening checklist

## SSH
- Key-only auth: `PasswordAuthentication no`, `PermitRootLogin no`
- Listen only on the Tailscale interface where possible
- `fail2ban` with the `sshd` jail as a second layer

## Firewall (nftables / ufw)
- Default deny inbound
- Allow 80/443 only from the Cloudflare tunnel / LAN
- Admin UIs (NPM :81, Proxmox :8006) reachable only over Tailscale

## Updates
- `unattended-upgrades` for security patches on Debian
- `make pull && make up STACK=...` weekly for containers (pinned major versions where it matters)

## Tailscale
- ACLs: only my devices can reach `tag:homelab`
- MagicDNS on, key expiry on for non-server devices

## Secrets
- Everything sensitive lives in `.env` (git-ignored), never in compose files
