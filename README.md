# almalinux10wsl

Setup and manage AlmaLinux 10 inside WSL.

## Purpose

This repository prepares AlmaLinux 10 in WSL with required packages and configuration.

It provides a clean Linux substrate for development and infrastructure tasks.

---

## Structure

TBD use windows credentials and key manager and any custom software configs

## Scripts

TBD Scripts provide environment software setup, update, verification, and revert capability.

---

This repository serves as the AlmaLinux WSL substrate layer.

## How to

Execute scritps from powershell

```bash
wsl -d AlmaLinux-10 -- bash -lc "cd /mnt/d/IT/repos/dotw-integration/dotw-almalinux10wsl && chmod +x setup.sh scripts/*.sh"
```

Execute scritps via the wrapper "towsl.ps1"

```bash
wsl -d AlmaLinux-10 -- bash -lc "cd /mnt/d/IT/repos/dotw-integration/dotw-almalinux10wsl && chmod +x setup.sh scripts/*.sh"
```
# trigger
