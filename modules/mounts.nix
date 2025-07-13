{
  config,
  lib,
  ...
}: {
  options.bell.mounts = {
    enableDesktopMounts = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mounts for filesystems on local drives on my desktop.";
    };
    enableServerMounts = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable mounts for filesystems on my server.";
    };
  };

  config = lib.mkMerge [
    {boot.supportedFilesystems = ["nfs" "ntfs"];}
    (lib.mkIf config.bell.mounts.enableDesktopMounts {
      fileSystems = {
        "/mnt/windows" = {
          device = "/dev/disk/by-uuid/8EF08D7FF08D6DF1";
          fsType = "ntfs";
        };

        "/mnt/x" = {
          device = "/dev/disk/by-uuid/9242C92442C90E43";
          fsType = "ntfs";
        };

        "/mnt/z" = {
          device = "/dev/disk/by-uuid/B2BCDA40BCD9FEB3";
          fsType = "ntfs";
        };
      };
    })
    (lib.mkIf config.bell.mounts.enableServerMounts {
      fileSystems = {
        "/mnt/hellblazer_data" = {
          device = "192.168.4.58:/mnt/hellblazer_on_the_net/hellblazer_data";
          fsType = "nfs";
          options = ["x-systemd.automount" "noauto" "x-systemd.requires=network-online.target"];
        };
      };
    })
  ];
}
