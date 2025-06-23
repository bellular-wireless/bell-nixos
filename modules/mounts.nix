{...}: {
  boot.supportedFilesystems = ["nfs" "ntfs"];
  #services.rpcbind.enable = true; # needed for NFS

  fileSystems = {
    "/mnt/hellblazer_data" = {
      device = "192.168.4.58:/mnt/hellblazer_on_the_net/hellblazer_data";
      fsType = "nfs";
    };

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
  #systemd.mounts = [
  #    {
  #        type = "nfs";
  #        mountConfig = {
  #            Options = "noatime,uid=1000,guid=100,rw,_netdev,auto";
  #        };
  #        what = "192.168.4.58:/mnt/hellblazer_on_the_net/hellblazer_data";
  #        where = "/mnt/hellblazer_data";
  #    }

  #    {
  #        type = "ntfs";
  #        mountConfig = {
  #            Options = "noatime,uid=1000,guid=100,rw";
  #        };
  #        what = "/dev/sda2";
  #        where = "/mnt/x";
  #    }

  #    {
  #        type = "ntfs";
  #        mountConfig = {
  #            Options = "noatime,uid=1000,guid=100,rw";
  #        };
  #        what = "/dev/sdb2";
  #        where = "/mnt/z";
  #    }

  #    {
  #        type = "ntfs";
  #        mountConfig = {
  #            Options = "noatime,uid=1000,guid=100,rw";
  #        };
  #        what = "/dev/nvme0n1p2";
  #        where = "/mnt/windows";
  #    }
  #];

  #systemd.automounts = [
  #    {
  #        wantedBy = [ "multi-user.target" ];
  #        automountConfig = {
  #            TimeoutIdleSec = "600";
  #        };
  #        where = "/mnt/hellblazer_data";
  #    }

  #    {
  #        wantedBy = [ "multi-user.target" ];
  #        automountConfig = {
  #            TimeoutIdleSec = "600";
  #        };
  #        where = "/mnt/x";
  #    }

  #    {
  #        wantedBy = [ "multi-user.target" ];
  #        automountConfig = {
  #            TimeoutIdleSec = "600";
  #        };
  #        where = "/mnt/z";
  #    }

  #    {
  #        wantedBy = [ "multi-user.target" ];
  #        automountConfig = {
  #            TimeoutIdleSec = "600";
  #        };
  #        where = "/mnt/windows";
  #    }
  #];
}
