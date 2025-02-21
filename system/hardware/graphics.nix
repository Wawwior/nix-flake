{
  systemSettings,
  config,
  lib,
  ...
}:
{

  options = {
    nvidia.enable = lib.mkEnableOption "nvidia support";
  };

  config = lib.mkIf (systemSettings.graphics.type == "nvidia") {
    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {

      prime = {
        intelBusId = systemSettings.graphics.intelBusId;
        nvidiaBusId = systemSettings.graphics.nvidiaBusId;
      };

      package = config.boot.kernelPackages.nvidiaPackages.latest;

    };

  };
}
