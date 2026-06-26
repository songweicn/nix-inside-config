# Dotfiles

Personal Linux user configuration.

This repository contains only user-managed configuration files.

## Philosophy

Keep everything simple.

* No Home Manager
* No symlink manager
* No GNU Stow
* No chezmoi
* No generated files
* No runtime state
* Whitelist instead of blacklist

The entire `~/.config` directory is ignored by default.

Only explicitly approved directories are tracked by Git.

## Structure

```text
~/.config
├── README.md
├── .gitignore
├── fish
├── ghostty
├── helix
├── nvim
├── fcitx5
├── rclone
│   ├── rclone.conf
│   ├── bisync-documents.sh
│   └── mount-pictures.sh
└── systemd
    └── user
        ├── rclone-pictures.service
        ├── rclone-documents.service
        └── rclone-documents.timer
```

## Git Strategy

The repository uses a whitelist strategy.

Everything is ignored first:

```gitignore
*
```

Only explicitly approved directories are tracked.

This prevents accidental commits of:

* browser profiles
* desktop settings
* caches
* application state
* machine-specific files

## User Configuration

### fish

Shell configuration.

### helix

Editor configuration.

### ghostty

Terminal configuration.

### nvim

Neovim configuration.

### fcitx5

Input method configuration.

Some generated files are intentionally ignored.

### rclone

Contains:

```text
rclone/
├── rclone.conf
├── bisync-documents.sh
└── mount-pictures.sh
```

`rclone.conf` is stored in this private repository.

Access tokens change automatically and do not necessarily require a Git commit.

## systemd User Services

User services live in:

```text
~/.config/systemd/user
```

Current services:

* rclone-pictures.service
* rclone-documents.service
* rclone-documents.timer

Pictures are mounted automatically after login.

Documents are synchronized periodically using `rclone bisync`.

## Data Architecture

Different kinds of data are managed differently.

### Configuration

```text
~/.config
```

Managed by Git.

### Documents

```text
~/Documents
```

Managed by OneDrive using `rclone bisync`.

A local copy is always available.

### Pictures

```text
~/Pictures
```

Mounted from OneDrive using `rclone mount`.

No large local duplicate is stored.

### Downloads

Local only.

### Projects

Git repositories.

## Restore

Clone directly into `~/.config`:

```bash
git clone git@github.com:songweicn/dotfiles.git ~/.config
```

Or if `~/.config` already exists:

```bash
git clone git@github.com:songweicn/dotfiles.git ~/dotfiles

cp -a ~/dotfiles/. ~/.config/
mv ~/dotfiles/.git ~/.config/
```

## Initialize Rclone

### Verify configuration

```bash
rclone listremotes
```

Expected:

```text
onedrive:
```

### First Documents synchronization

Run only once on a new machine:

```bash
~/.config/rclone/bisync-documents.sh --resync -P
```

After the first synchronization completes successfully, normal synchronization is simply:

```bash
~/.config/rclone/bisync-documents.sh -P
```

### Test Pictures mount

Run manually:

```bash
~/.config/rclone/mount-pictures.sh
```

Verify:

```bash
findmnt ~/Pictures
```

Expected:

```text
onedrive:Pictures
```

Unmount manually:

```bash
fusermount3 -u ~/Pictures
```

### Enable user services

Reload user services:

```bash
systemctl --user daemon-reload
```

Enable automatic Pictures mount:

```bash
systemctl --user enable --now rclone-pictures.service
```

Enable scheduled Documents synchronization:

```bash
systemctl --user enable --now rclone-documents.timer
```

Verify:

```bash
systemctl --user status rclone-pictures.service

systemctl --user list-timers
```

## Git Workflow

```bash
cd ~/.config

git status
git add -A
git commit -m "update dotfiles"
git push
```

Review changes carefully before committing.

Generated files should never be committed.
