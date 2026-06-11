{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;

  # Évite les conflits avec les drivers open-source
  boot.blacklistedKernelModules = [
    "nouveau"
    "nova_core"
  ];

  # Nécessaire pour la veille/hibernation sur RTX 4000+
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
  '';

  # Cache shaders étendu pour le gaming
  environment.variables = {
    __GL_SHADER_DISK_CACHE_SIZE = "12000000000";
  };

  # Services systemd pour veille/hibernation
  systemd.services.nvidia-suspend = {
    description = "NVIDIA system suspend actions";
    wantedBy = [ "systemd-suspend.service" ];
    before = [ "systemd-suspend.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.boot.kernelPackages.nvidiaPackages.stable}/bin/nvidia-sleep.sh suspend";
    };
  };

  systemd.services.nvidia-hibernate = {
    description = "NVIDIA system hibernate actions";
    wantedBy = [ "systemd-hibernate.service" ];
    before = [ "systemd-hibernate.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.boot.kernelPackages.nvidiaPackages.stable}/bin/nvidia-sleep.sh hibernate";
    };
  };

  systemd.services.nvidia-resume = {
    description = "NVIDIA system resume actions";
    wantedBy = [
      "systemd-suspend.service"
      "systemd-hibernate.service"
    ];
    after = [
      "systemd-suspend.service"
      "systemd-hibernate.service"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${config.boot.kernelPackages.nvidiaPackages.stable}/bin/nvidia-sleep.sh resume";
    };
  };
}
