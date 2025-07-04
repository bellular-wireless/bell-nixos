{pkgs-unstable-small, ...}: {
  services.ollama = {
    package = pkgs-unstable-small.ollama;
    enable = false;
    acceleration = "cuda";
  };

  services.open-webui.enable = false;
}
