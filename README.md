# nix-inside-config

> A curated Linux configuration repository with **Nix inside**, not around.

This repository is my personal Linux configuration, built around a simple idea:

> **Only intentionally maintained configuration and personal assets belong in Git.**

Everything else—runtime state, caches, generated files, OAuth tokens, and secrets—is intentionally excluded.

---

# Philosophy

This repository values long-term maintainability over convenience.

## Principles

- One source of truth: `~/.config`
- Explicit over implicit
- Simplicity over abstraction
- Configuration over runtime state
- Maintain only what is intentional
- Prefer understanding over automation

The goal is not to collect every configuration file, but to build a clean and sustainable system that remains understandable years later.

---

# Why "nix-inside-config"?

Although this repository is centered around NixOS, it is **not** a Nix-only repository.

It also contains:

- terminal configuration
- editor configuration
- desktop configuration
- user assets
- Git workflow
- wallpapers
- personal customization

Nix is an important part of the system, but not the whole system.

---

# Design Goals

This repository intentionally avoids unnecessary abstraction.

Current choices:

- No Home Manager
- No Flakes
- No chezmoi

The current objective is to first understand every file before introducing another abstraction layer.

---

# Repository Layout

```text
~/.config
├── README.md
├── .gitignore
├── justfile
├── nixos
├── cosmic
├── fish
├── ghostty
├── helix
├── nvim
├── fastfetch
├── GIMP
├── git
├── gh
├── systemd
├── yazi

---text

# Git Strategy

This repository follows a **whitelist** strategy. See https://github.com/songweicn/nix-inside-config/blob/main/.gitignore

Everything is ignored by default.

Only carefully selected files are tracked.

Advantages:

- Cleaner history
- Smaller repository
- Less maintenance
- No accidental secrets
- Easier long-term review

The whitelist evolves over time based on actual application behavior rather than assumptions.

---

# NixOS

The `nixos/` directory contains the system configuration.

Current architecture:

```text
nixos/
├── configuration.nix
├── host.link
└── hosts/
    ├── thinkpad/
    └── nas/
```

## Design

- Single `configuration.nix`
- Machine-specific configuration inside `hosts/`
- `host.link` selects the active machine
- Hardware configuration is version controlled
- SOPS prepared for future secret management

The objective is to keep the overall configuration readable instead of heavily modularized.

