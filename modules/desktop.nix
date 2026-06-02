{ ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout  = "fr";
      variant = "";
    };
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm.enable    = true;
  services.desktopManager.plasma6.enable = true;
}
