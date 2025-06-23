{
  inputs,
  pkgs,
  configPath,
  config,
  host,
  user,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    (import ./shell/fsh.nix {inherit configPath host user;})
    ./git.nix
    inputs.nixvim.homeModules.nixvim
    ./nixvim/options.nix
    ./nixvim/keymaps.nix
    ./nixvim/plugins
    ./nixvim/autocommands.nix
    ./desktop/hyprland/hyprland.nix
    ./desktop/waybar/waybar.nix
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["thunar.desktop"];
      "image/*" = ["org.xfce.ristretto.desktop"];
      "image/png" = ["org.xfce.ristretto.desktop"];
      "image/jpeg" = ["org.xfce.ristretto.desktop"];
      "x-scheme-handler/https" = ["zen-twilight.desktop"];
      "x-scheme-handler/http" = ["zen-twilight.desktop"];
      "x-scheme-handler/mailto" = ["zen-twilight.desktop"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.file = {
    ".config/ghostty/config".source = dotfiles/ghostty/config;
    ".config/fish/themes" = {
      source = shell/themes;
      recursive = true;
    };
    ".config/hypr/xdph.conf".source = desktop/hyprland/xdph.conf;
    #".config/nvim" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${configPath}home/dotfiles/nvim";
    #  recursive = true;
    #};
    # ".config/OpenRGB" = {
    #   source = dotfiles/OpenRGB;
    #   recursive = true;
    # };
  };

  programs.home-manager.enable = true;

  programs.vesktop.enable = true;

  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.rose-pine-gtk-theme;
  #     name = "rose-pine-gtk-theme";
  #   };
  #   cursorTheme = {
  #     package = pkgs.rose-pine-cursor;
  #     name = "rose-pine-cursor";
  #   };
  # };
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    polarity = "dark";
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      monospace = {
        name = "0xProto Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
      };
    };
    cursor = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 20;
    };
    targets = {
      ghostty.enable = false;
      nixvim.enable = false;
      fish.enable = false;
      waybar.enable = false;
      # nixcord.enable = false;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/rose-pine-pine".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine-pine";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=rose-pine-pine";
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
  };

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
