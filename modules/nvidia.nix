{ config, ... }:

{
  hardware.nvidia = {
    open               = true;   # modules open-source, stable sur Ada Lovelace
    modesetting.enable = true;
    nvidiaSettings     = true;
    powerManagement.enable = false;
    package            = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;
}
