{pkgs-unstable-small, ...}: {
  services.ollama = {
    package = pkgs-unstable-small.ollama-cuda;
    enable = false;
  };

  services.open-webui.enable = false;
}
