{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    qbittorrent
    vivaldi
    vivaldi-ffmpeg-codecs
    brave
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
    # Azahar avec XWayland forcé (fix NVIDIA + Wayland)
    (pkgs.symlinkJoin {
      name = "azahar-wrapped";
      paths = [ pkgs.azahar ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/azahar --set QT_QPA_PLATFORM xcb
      '';
    })
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

}
