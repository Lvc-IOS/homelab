# Proxmox notes

## Layout

| VM / CT | OS | vCPU | RAM | Disk | Purpose |
|---|---|---|---|---|---|
| `docker-01` | Debian 12 | 4 | 16 GB | 120 GB (local-lvm) | Docker host for every stack in this repo |
| `pbs` | Proxmox Backup Server | 2 | 4 GB | external HDD | Nightly backups |
| `arch-dev` | Arch Linux | 4 | 8 GB | 60 GB | Throwaway dev box |

## Docker VM

- Machine type `q35`, CPU type `host`, VirtIO SCSI single + `discard=on` + `iothread=1`
- QEMU guest agent enabled (`apt install qemu-guest-agent`)
- Docker installed from the official repo, user added to the `docker` group

## Backups

- PBS job every night at 02:30, mode `snapshot`, keep 7 daily / 4 weekly / 3 monthly
- `stacks/*/data` volumes live inside the VM disk, so they're covered by the VM backup
- Monthly restore test into a temporary VM ID

## Useful commands

```bash
qm list                          # list VMs
qm guest exec 101 -- uptime      # run a command through the guest agent
pvesm status                     # storage usage
vzdump 101 --mode snapshot --storage pbs
```
