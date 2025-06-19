{
  configPath,
  user,
  host,
  ...
}: {
  home.shell.enableShellIntegration = true;
  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    hms = "home-manager switch --flake ${configPath}/#${user}";
    nixr = "sudo nixos-rebuild switch --flake ${configPath}/#${host}";
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "tokyo";
  };
}
