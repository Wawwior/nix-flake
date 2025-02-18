{ systemSettings, config, ... }: {

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ systemSettings.gpuType ];

    hardware.nvidia = 
        if (systemSettings.gpuType == "nvidia") then {

            prime = {
                intelBusId = systemSettings.intelBusId;
                nvidiaBusId = systemSettings.nvidiaBusId;
            };

            package = config.boot.kernelPackages.nvidiaPackages.latest;

        } else {};

}
