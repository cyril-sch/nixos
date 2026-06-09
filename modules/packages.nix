{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    librewolf
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
    # Polices
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
  ];

  programs.zsh.enable = true;

  programs.firefox = {
    enable = true;
    languagePacks = [ "fr" ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      enkia.tokyo-night
      bbenoist.nix
      ms-ceintl.vscode-language-pack-fr
    ];
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
