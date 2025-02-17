{ systemSettings, config, ... }: {

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ systemSettings.gpuType ];

    hardware.nvidia = 
        if (systemSettings.gpuType == "nvidia") then {

            modesetting.enable = true;

            powerManagement.enable = false;

            powerManagement.finegrained = false;

            open = systemSettings.nvidiaOpen;

            nvidiaSettings = true;

            prime = {
                intelBusId = systemSettings.intelBusId;
                nvidiaBusId = systemSettings.nvidiaBusId;
            };

            package = config.boot.kernelPackages.nvidiaPackages.stable;


        } else {};

}
