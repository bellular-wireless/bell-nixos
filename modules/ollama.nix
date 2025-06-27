{pkgs-unstable-small, ...}: {
  services.ollama = {
    package = pkgs-unstable-small.ollama;
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui.enable = true;
}
