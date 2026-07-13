{ config, lib, pkgs, ... }:

{
  imports = [
    ./machine.nix
  ];

  # ===== Base =====
  system.stateVersion = "26.05";

  time.timeZone = "America/Winnipeg";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  # ===== Bootloader =====
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # ===== Kernel =====
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ===== Networking and Firewall =====
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
    ];
    allowedUDPPorts = [ ];
  };

  # ===== Users =====
  users.groups = {
    plugdev = {};
    weis = { gid = 1000; };
  };

  users.users.weis = {
    isNormalUser = true;
    uid = 1000;
    group = "weis";
    description = "Wei Song";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "render"
    ];
  };

  # ===== Wayland =====
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # ===== Shell / Git / Editor =====
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Wei Song";
      user.email = "songweicn@gmail.com";
    };
  };

  environment.variables.EDITOR = "hx";

  # ===== Common Services =====
  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=1G
    RuntimeMaxUse=200M
  '';

  # ===== Common Packages =====
  environment.systemPackages = with pkgs; [

    # System
    fastfetch
    tree
    btop

    # Security
    age

    # Development
    git
    helix
    neovim
    lua-language-server
    stylua
    just

    # Network
    wget
    curl
    tailscale
    rclone

    # Archive
    zip
    unzip

    # Search
    ripgrep
    fd
    fzf

    # Docker
    docker-compose
    lazygit
    lazydocker

    # Terminal
    wl-clipboard
    yazi
    zellij
  ];
}
