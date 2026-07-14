# nix-inside-config

> A Linux configuration repository with **Nix inside**, not around.

Unlike most NixOS repositories, this project is **not centered around Flakes, Home Manager, or large module hierarchies**.

Instead, it is built around a much simpler idea:

> Keep every configuration file where it naturally belongs, and manage it with Git only after it becomes a stable, intentionally maintained configuration.

The repository currently has:

- No Flakes
- No Home Manager
- No GNU Stow
- No unnecessary modules
- No abstraction for the sake of abstraction

Most Nix files are well under 200 lines.

Instead of splitting one file into dozens of modules, the goal is to keep **the smallest number of Nix files while remaining readable**.

Configuration stays **at its original location**, and Git manages the final result instead of generating configuration somewhere else.

---

# Repository Layout

The repository is simply a curated subset of `~/.config`.

Only directories that are intentionally maintained are tracked.

```text
~/.config
├── README.md
├── .gitignore
├── justfile
│
├── nixos
├── cosmic
├── fish
├── ghostty
├── helix
├── nvim
├── fastfetch
├── GIMP
├── fcitx5
├── yazi
├── systemd
│
├── git
├── gh
├── lazygit
├── superfile
│
├── mimeapps.list
├── user-dirs.dirs
└── starship.toml
```

---

# Whitelist Strategy

The repository follows a strict whitelist policy.

Everything is ignored by default.

Only intentionally maintained configuration is included.

```gitignore
*

!.gitignore
!README.md

!nixos/
!fish/
!ghostty/
!helix/
!nvim/
!fastfetch/
!cosmic/
!GIMP/
...
```

Runtime state, caches, session files, temporary files and secrets are intentionally excluded.

This keeps the repository small, clean and predictable.

---

# NixOS Layout

The NixOS configuration is intentionally minimal.

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

The design is straightforward:

- `configuration.nix` contains the shared system configuration.
- `hosts/` stores machine-specific configuration.
- `host.link` selects the active host.
- Hardware configuration remains with the corresponding machine.

No complicated module hierarchy is required.

---

# Two Symlinks

Only two symbolic links are needed.

## 1. Select the current host

```text
host.link
    └── hosts/thinkpad/default.nix
```

`configuration.nix` imports only `host.link`.

Changing the target changes the active machine.

---

## 2. Tell NixOS where the configuration lives

```text
/etc/nixos
    └── ~/.config/nixos
```

This allows rebuilding directly from the repository.

```bash
sudo nixos-rebuild switch
```

No additional wrapper scripts are required.

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

git pull

↓

git push
```

Review every change before committing.

Git history should describe intentional configuration changes instead of application runtime state.

---

# License

MIT
