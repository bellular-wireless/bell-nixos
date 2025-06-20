{
  config,
  pkgs,
  pkgs-110bd4d,
  inputs,
  host,
  user,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/mounts.nix
    ./modules/openrgb.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    pkgs-110bd4d.refind
    nfs-utils
    ntfs3g
    bitwarden-desktop
    ghostty
    neofetch
    ripgrep
    gnumake
    unzip
    gcc
    fd
    xclip
    wowup-cf
    heroic
    #openrgb-with-all-plugins
    wget
    wl-clipboard
    rose-pine-kvantum
    rose-pine-hyprcursor
    rose-pine-cursor
    kdePackages.dolphin
    pavucontrol
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  services.xserver.videoDrivers = ["nvidia"];

  # Graphics
  hardware.graphics = {
    enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    packages = [
      "com.usebottles.bottles"
      "com.discordapp.Discord"
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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
  };
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting \"it is burning.\" -r --time --cmd 'uwsm start -- hyprland.desktop'";
  #       user = "greeter";
  #     };
  #     initial_session = {
  #       command = "uwsm start -- hyprland.desktop";
  #       user = "bell";
  #     };
  #   };
  # };
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };
  # services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
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
