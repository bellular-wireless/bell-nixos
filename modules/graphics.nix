{
  config,
  lib,
  ...
}: {
  options.bell.graphics = {
    enableNvidia = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable NVIDIA graphics support.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.bell.graphics.enableNvidia {
      services.xserver.videoDrivers = ["nvidia"];

      hardware.graphics = {
        enable = true;
      };

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
    })
  ];
}
