# nix-inside-config

> **Keep configuration where it belongs. Manage it where it matters.**
>
> **Git manages the destination, not the source.**
>
> **Simple enough to understand in one afternoon.**

`nix-inside-config` is a Linux configuration repository built around a simple idea:

> **Keep configuration files at their original location, and manage only intentionally maintained configuration with Git.**

Unlike many NixOS repositories, this project is **not centered around Flakes, Home Manager, or complex module hierarchies**. Instead, it focuses on simplicity, readability, and long-term maintainability.

---

# Features

- Configuration stays where applications expect it.
- Git manages the final configuration instead of generating it elsewhere.
- No Flakes.
- No Home Manager.
- No GNU Stow.
- No unnecessary modules.
- Minimal Nix files (typically well under 200 lines).
- Whitelist-based Git repository.

The goal is to keep the number of Nix files as small as possible while remaining easy to understand.

---

# Repository Layout

This repository is simply a curated subset of `~/.config`.

```text
~/.config
├── README.md
├── .gitignore
├── justfile
├── nixos #👋Hi,NixOSer I'm here.
├── cosmic
├── fastfetch
├── fcitx5
├── fish
├── GIMP
├── ghostty
├── helix
├── nvim
├── yazi
├── systemd
├── git
├── gh
├── lazygit
├── superfile
│
└── starship.toml
```

---

# Whitelist Strategy

Everything is ignored by default.

Only intentionally maintained configuration is tracked.

The repository follows a strict whitelist strategy defined in `.gitignore`.

This avoids committing:

- runtime state
- cache
- session files
- crash logs
- temporary files
- secrets

The whitelist evolves based on actual application behavior rather than assumptions.

---

# NixOS Layout

```text
nixos
├── configuration.nix
├── host.link -> hosts/thinkpad/default.nix
├── hosts
│   ├── nas
│   │   └── default.nix
│   └── thinkpad
│       ├── default.nix
│       └── hardware-configuration.nix
├── secrets
└── README.md
```

Design principles:

- One shared `configuration.nix`
- Host-specific configuration inside `hosts/`
- Hardware configuration stays with its host
- No unnecessary module hierarchy

---

# Two Symlinks

The entire architecture relies on only two symbolic links.

## 1. Select the active host

```text
host.link
    └── hosts/thinkpad/default.nix
```

`configuration.nix` imports only `host.link`.

Switching machines only requires changing the symbolic link.

---

## 2. Point NixOS to this repository

```text
/etc/nixos
    └── ~/.config/nixos
```

With this link in place, rebuilding works exactly as expected:

```bash
sudo nixos-rebuild switch
```

No wrapper scripts are required.

---

# Workflow

```text
Edit
  ↓
git status
  ↓
git add
  ↓
git commit
  ↓
git push
```

Every commit should represent an intentional configuration change, not application runtime state.

---

# License

MIT
