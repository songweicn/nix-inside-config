{ pkgs, ... }:

let
  dockerCompose = "${pkgs.docker-compose}/bin/docker-compose";
in
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # ===== hostName =====
  networking.hostName = "nas";

  # ===== groups =====
  users.groups.nas = {};

  users.users.weis.extraGroups = [
    "nas"
  ];

  # ===== data mount disk =====
  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noatime"
    ];
  };

  # ===== Firewall Ports =====
  networking.firewall.allowedTCPPorts = [
    2283 # Immich
    5055 # Seerr
    7878 # Radarr
    8080 # qBittorrent
    8096 # Jellyfin
    8989 # Sonarr
    9696 # Prowlarr
    8000 # Paperless-ngx
    22000 # syncthing
  ];

  # ===== data Home link =====
  systemd.tmpfiles.rules = [
    "d /data 2775 weis nas - -"

    "d /data/documents 2775 weis nas - -"
    "d /data/downloads 2775 weis nas - -"
    "d /data/pictures 2775 weis nas - -"
    "d /data/music 2775 weis nas - -"

    "d /data/videos 2775 weis nas - -"
    "d /data/videos/movies 2775 weis nas - -"
    "d /data/videos/tv 2775 weis nas - -"

    "d /data/shared 2775 weis nas - -"
    "d /data/backups 2770 weis nas - -"
    "d /data/.secrets 2770 weis nas - -"

    "L+ /home/weis/Documents - - - - /data/documents"
    "L+ /home/weis/Downloads - - - - /data/downloads"
    "L+ /home/weis/Pictures - - - - /data/pictures"
    "L+ /home/weis/Music - - - - /data/music"
    "L+ /home/weis/Videos - - - - /data/videos"
  ];

  # ===== Docker Compose：media =====
  systemd.services.compose-media = {
    description = "Docker Compose stack: media";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    requires = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/data/compose/media";
      ExecStart = "${dockerCompose} up -d";
      ExecStop = "${dockerCompose} down";
      TimeoutStartSec = 0;
    };
  };

  # ===== Docker Compose：immich =====
  systemd.services.compose-immich = {
    description = "Docker Compose stack: immich";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    requires = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/data/compose/immich";
      ExecStart = "${dockerCompose} up -d";
      ExecStop = "${dockerCompose} down";
      TimeoutStartSec = 0;
    };
  };
}
