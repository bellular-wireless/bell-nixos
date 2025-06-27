{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pkgs-110bd4d.url = "github:nixos/nixpkgs/110bd4dbeef553a1190af1571b94a5d8b7a7114c";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    hyprland.url = "github:hyprwm/Hyprland";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    templ.url = "github:a-h/templ";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    configPath = "/home/bell/.nixos";
    user = "bell";
    host = "hellkeeper";
  in {
    nixosConfigurations.hellkeeper = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.stylix.nixosModules.stylix
        ./configuration.nix
      ];
      specialArgs = {
        pkgs-110bd4d = import inputs.pkgs-110bd4d {
          inherit system;
        };
        pkgs-unstable-small = import inputs.nixpkgs-unstable-small {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs configPath host user;
      };
    };

    homeConfigurations = {
      bell = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.hyprland.homeManagerModules.default
          inputs.stylix.homeModules.stylix
          ./home/home.nix
        ];

        extraSpecialArgs = {
          inherit inputs configPath system host user;
        };
      };
    };
  };
}
