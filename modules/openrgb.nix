{pkgs, ...}: let
  pink-rgb = pkgs.writeScriptBin "pink-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color FF00FF
    done
  '';
in {
  services.hardware.openrgb.enable = true;
  services.udev.packages = [pkgs.openrgb];
  boot.kernelModules = ["12c-dev"];
  systemd.services.pink-rgb = {
    description = "pink-rgb";
    serviceConfig = {
      execStart = "${pink-rgb}/bin/pink-rgb";
      Type = "oneshot";
    };
    wantedBy = ["multi-user.target"];
  };
}
