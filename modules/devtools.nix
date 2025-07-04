{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    go
    air
    templ
  ];
}
