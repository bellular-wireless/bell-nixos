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
      "text/x-log" = ["org.kde.kate.desktop"];
      "inode/directory" = ["thunar.desktop"];
      "image/*" = ["org.xfce.ristretto.desktop"];
      "image/png" = ["org.xfce.ristretto.desktop"];
      "image/jpeg" = ["org.xfce.ristretto.desktop"];
      "x-scheme-handler/https" = ["zen-twilight.desktop"];
      "x-scheme-handler/http" = ["zen-twilight.desktop"];
      "x-scheme-handler/mailto" = ["zen-twilight.desktop"];
      "x-scheme-handler/discord" = ["vesktop.desktop"];
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
        package = pkgs.noto-fonts-color-emoji;
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
      hyprland.enable = false;
      hyprlock.enable = false;
      rofi.enable = false;
      zen-browser.profileNames = ["default"];
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
    profiles.default.search = {
      force = true;
      default = "ddg";
    };
    profiles.default.settings = {
      "zen.view.use-single-toolbar" = false;
    };
    profiles.default.bookmarks = {
      force = true;
      settings = [
        {
          name = "TrueNAS";
          # toolbar = true;
          url = "http://192.168.0.8:81";
        }
        {
          name = "Deluge";
          # tooblar = true;
          url = "http://192.168.0.8:8112";
        }
        {
          name = "SABnzbd";
          # toolbar = true;
          url = "http://192.168.0.8:8080";
        }
        {
          name = "Calibre";
          # toolbar = true;
          url = "http://192.168.0.8:8090";
        }
      ];
    };
    profiles.default.pinsForce = true;
    profiles.default.pins = {
      "youtube" = {
        id = "f3ce2f51-412e-463a-b234-f87ebc95f5ce";
        url = "https://www.youtube.com";
        isEssential = true;
        position = 101;
      };
      "protonmail" = {
        id = "15cf1c38-fb1a-4ff8-a12a-0c10ca65ab32";
        url = "https://mail.proton.me";
        isEssential = true;
        position = 102;
      };
      "jellyfin" = {
        id = "5aae067d-c716-4239-832a-823e77b924e9";
        url = "https://jellyfin.fuck.bargains/";
        isEssential = true;
        position = 103;
      };
      "jellyseer" = {
        id = "3f41601c-a388-40b0-bcf0-01ea084a7c9e";
        url = "https://jellyseerr.fuck.bargains/";
        isEssential = true;
        position = 104;
      };
      "aws-learning" = {
        id = "4328136c-85cf-421b-aed9-f0a974a32f8f";
        url = "https://skillbuilder.aws/";
        isEssential = false;
        position = 105;
      };
      "nix-search" = {
        id = "793ffbbc-29e9-476f-bc3b-7120978a1da3";
        url = "https://search.nixos.org/";
        isEssential = false;
        position = 106;
      };
      "home-manager-search" = {
        id = "391bb28d-0cff-47ec-b750-1111753a08f2";
        url = "https://home-manager-options.extranix.com/";
        isEssential = false;
        position = 107;
      };
    };
  };

  # programs.lutris = {
  #   enable = true;
  #   steamPackage = pkgs.steam;
  # };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
}
