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
    hyprlogout = "hyprctl dispatch exit";
    vimhellblazer = "vim scp://root@192.168.4.58//mnt/hellblazer_on_the_net/docker/";
  };
  programs.fish.loginShellInit = ''
    uwsm start select
  '';

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "tokyo";
  };
}
