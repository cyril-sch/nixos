{ pkgs, lib, ... }:

{
  home.username = "cyril";
  home.homeDirectory = "/home/cyril";

  # ============================================================
  # PAQUETS UTILISATEUR
  # ============================================================

  home.packages = with pkgs; [
    # Ajoute ici les paquets spécifiques à ton environnement utilisateur
  ];

  # ============================================================
  # SHELL & TERMINAL
  # ============================================================

  programs.bash.enable = true;

  programs.ghostty = {
    enable = true;
  };

  # ============================================================
  # VISUAL STUDIO CODE
  # ============================================================

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        enkia.tokyo-night
        ms-ceintl.vscode-language-pack-fr
      ];
    };
  };

  # ============================================================
  # GIT
  # ============================================================

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Cyril Schmitt";
        email = "cyril.m.schmitt@protonmail.com";
      };
    };
  };

  # ============================================================
  # STARSHIP
  # ============================================================

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # ============================================================
  # ALIAS
  # ============================================================

  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#QUASAR";
    rebuild-update = "sudo nix flake update --flake ~/nixos && sudo nixos-rebuild switch --flake ~/nixos#QUASAR";
  };

  # ============================================================

  home.enableNixpkgsReleaseCheck = false;

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Ne pas modifier — correspond à la version de Home Manager utilisée
  home.stateVersion = "26.05";
}
