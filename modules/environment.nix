{ ... }:

{
  environment.sessionVariables = {
    LANG = "fr_FR.UTF-8";

    # Applications Electron en Wayland natif (VSCode, etc.)
    NIXOS_OZONE_WL = "1";

    # Firefox en Wayland natif
    MOZ_ENABLE_WAYLAND = "1";

    # Backends graphiques
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";

    # Accélération matérielle vidéo NVIDIA
    LIBVA_DRIVER_NAME = "nvidia";

    # G-Sync / VRR — passer à "1" si écran compatible
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
  };
}
