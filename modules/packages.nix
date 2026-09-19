{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    qbittorrent
    vlc
    libdvdcss
    protonplus
    candy-icons
    nixd
    nixfmt
    wayland-utils
    wl-clipboard
    mangohud
    faugus-launcher
    stow
    proton-vpn
    shipwright
    zenity
    unzip
    p7zip
    obsidian
    librewolf-bin
    # Polices
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
  ];

  programs.firefox = {
    enable = true;
    languagePacks = [ "fr" ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
        inhibit_screensaver = 1;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermizer_mode = 1; # Mode performances Nvidia
      };
      cpu = {
        park_cores = "no";
        pin_cores = "yes";
      };
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
      expat
      libffi
      zlib
      openssl
      bzip2
      xz
      ncurses
      readline
      sqlite
      freetype
      gnutls
    ];
  };

  # Nécessaire pour bwrap/pressure-vessel (Steam Linux Runtime) : ces outils
  # s'attendent à trouver /bin/true dans un FHS classique, absent sur NixOS.
  systemd.tmpfiles.rules = [
    "L+ /bin/true - - - - ${pkgs.coreutils}/bin/true"
  ];

  system.activationScripts.ldconfigCache = ''
    mkdir -p /var/cache/ldconfig
    ${pkgs.glibc.bin}/sbin/ldconfig -C /var/cache/ldconfig/ld.so.cache
  '';

}
