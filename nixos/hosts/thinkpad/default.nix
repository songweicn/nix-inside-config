{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ===== Identity =====

  networking.hostName = "thinkpad";

  # ===== Desktop =====

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  programs.niri.enable = true;

  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # ===== Chinese Input =====

  i18n.inputMethod.enable = true;

  i18n.inputMethod.type = "fcitx5";

  i18n.inputMethod.fcitx5.addons = with pkgs; [
    qt6Packages.fcitx5-chinese-addons
    fcitx5-rime
    fcitx5-gtk
  ];

  # ===== Fonts =====
  fonts = { enableDefaultPackages = true;
  fontDir.enable = true;
  packages = with pkgs; [
     inter
     ibm-plex
     roboto
     open-sans
     source-sans
     source-serif
     source-code-pro
     liberation_ttf
     dejavu_fonts
     ubuntu-classic
     jetbrains-mono
     fira-code
     nerd-fonts.jetbrains-mono
     nerd-fonts.fira-code
     nerd-fonts.symbols-only
     font-awesome
     material-icons
     material-design-icons
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-cjk-serif
     noto-fonts-color-emoji
     sarasa-gothic
     lxgw-wenkai
     source-han-sans
     source-han-serif
     wqy_microhei
     wqy_zenhei
     corefonts vista-fonts
   ];

   fontconfig = {
     enable = true;
     defaultFonts = {
       serif = [ "Noto Serif CJK SC" "Noto Serif" "Source Han Serif SC" ];
       sansSerif = [ "Noto Sans CJK SC" "Noto Sans" "Source Han Sans SC" "Inter" ];
       monospace = [ "JetBrainsMono Nerd Font" "JetBrains Mono" "Noto Sans Mono CJK SC" ];
       emoji = [ "Noto Color Emoji"];
       };
     };
   };

  # ===== Desktop Packages =====
  environment.systemPackages = with pkgs; [

    # Terminal
    ghostty

    # Browsers
    firefox
    google-chrome

    # Productivity
    obsidian
    wechat

    # Editors
    zed-editor

    # Creative
    gimp
    inkscape
    kdePackages.kdenlive
    libheif

    # Theme
    noctalia-shell
    dms-shell
  ];
  
  # ===== Power Management =====

  powerManagement.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

  # ===== Data Layout =====

  # ThinkPad stores user data directly under /home.
  #
  # Documents  -> OneDrive (rclone bisync)
  # Pictures   -> OneDrive (rclone mount)
  # Downloads  -> Local
  # Projects   -> Git

}
