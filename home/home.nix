{
  inputs,
  pkgs,
  configPath,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    (import ./shell/fsh.nix {inherit configPath;})
    ./git.nix
    inputs.nixvim.homeModules.nixvim
    ./nixvim/options.nix
    ./nixvim/keymaps.nix
    ./nixvim/plugins
    ./nixvim/autocommands.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bell";
  home.homeDirectory = "/home/bell";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.file = {
    ".config/ghostty/config".source = dotfiles/ghostty/config;
    #".config/nvim" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${configPath}home/dotfiles/nvim";
    #  recursive = true;
    #};
    ".config/OpenRGB" = {
      source = dotfiles/OpenRGB;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };

  programs.lutris = {
    enable = true;
    steamPackage = pkgs.steam;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
