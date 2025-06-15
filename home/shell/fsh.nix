{ configPath, ... }:
{
  home.shell.enableShellIntegration = true;
  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    hms = "home-manager switch --flake ${configPath}#bell";
    nixr = "sudo nixos-rebuild switch --flake ${configPath}#hellkeeper";
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "tokyo";
  };
}
