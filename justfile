set shell := ["fish", "-c"]

# Show managed config tree
config-tree:
    cd ~/.config; and tree -a -L 2 (git ls-files | cut -d/ -f1 | sort -u)

# Git status
config-status:
    cd ~/.config; and git status

# Git diff
config-diff:
    cd ~/.config; and git diff

# Pull latest dotfiles
config-pull:
    cd ~/.config; and git pull

# NixOS rebuild
rebuild:
    sudo nixos-rebuild switch

# Update flake (future)
update:
    nix flake update

# Collect garbage
gc:
    sudo nix-collect-garbage -d
