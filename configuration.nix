{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/nvidia.nix
    ./modules/audio.nix
    ./modules/packages.nix
    ./modules/environment.nix
  ];

  # ============================================================
  # RÉSEAU
  # ============================================================

  networking.hostName = "QUASAR";
  networking.networkmanager.enable = true;

  # ============================================================
  # UTILISATEUR
  # ============================================================

  users.users.cyril = {
    isNormalUser = true;
    description = "Cyril Schmitt";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "kvm"
    ];
    shell = pkgs.bash;
  };

  # ============================================================
  # SERVICES DIVERS
  # ============================================================

  services.printing.enable = true;
  services.openssh.enable = true;
  services.flatpak.enable = true;
  fonts.fontDir.enable = true;

  # ============================================================
  # NETTOYAGE DES GENERATIONS
  # ============================================================

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--keep-last 7";
    persistent = true;
  };

  # ============================================================
  # SPECIALISATION — FALLBACK (kernel vanilla)
  # ============================================================

  # specialisation.fallback.configuration = {
  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
  # };

  # ============================================================

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
