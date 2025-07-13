{...}: {
  imports = [
    ../configuration.nix
  ];
  bell.mounts.enableDesktopMounts = false;
  bell.graphics.enableNvidia = false;
  bell.hypr.enableDesktopMonitors = false;
}
