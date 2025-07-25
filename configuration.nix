{
  pkgs,
  pkgs-110bd4d,
  inputs,
  host,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/mounts.nix
    ./modules/openrgb.nix
    ./modules/ollama.nix
    ./modules/devtools.nix
    ./modules/graphics.nix
  ];

  nixpkgs.overlays = [
    inputs.templ.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    git
    pkgs-110bd4d.refind
    nfs-utils
    ntfs3g
    bitwarden-desktop
    ghostty
    fastfetch
    ripgrep
    gnumake
    unzip
    gcc
    fd
    xclip
    wowup-cf
    heroic
    wget
    wl-clipboard
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    rose-pine-hyprcursor
    rose-pine-cursor
    pavucontrol
    openrgb-with-all-plugins
    wlr-randr
    xorg.xrandr
    hyprshot
    gimp
    xfce.ristretto
  ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "launcher.moe";
        location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
      }
    ];
    packages = [
      "com.usebottles.bottles"
      {
        appId = "moe.launcher.an-anime-game-launcher";
        origin = "launcher.moe";
      }
    ];
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman thunar-vcs-plugin];
  };

  services.tumbler.enable = true;

  services.gvfs.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  boot = {
    # Bootloader.
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        timeoutStyle = "hidden";
      };
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  programs.fish.enable = true;
  stylix.targets.fish.enable = false;

  system.nixos.label = "NixOS";

  networking.hostName = "${host}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable desktop stuffz
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."${user}" = {
    isNormalUser = true;
    uid = 1000;
    description = "${user}";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.zed-mono
    nerd-fonts.hack
    nerd-fonts._0xproto
    noto-fonts
  ];

  # NeoVim

  #programs.neovim = {
  #  enable = true;
  #  vimAlias = true;
  #};

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  programs.ssh.startAgent = true;

  programs.steam.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
