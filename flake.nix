{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pkgs-110bd4d.url = "github:nixos/nixpkgs/110bd4dbeef553a1190af1571b94a5d8b7a7114c";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      configPath = "/home/bell/.nixos/";
    in {
    nixosConfigurations.hellkeeper = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
      ];
      specialArgs = {
          pkgs-110bd4d = import inputs.pkgs-110bd4d {
            inherit system;
          };
          inherit configPath;
      };
    };

    homeConfigurations = {
      bell = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];

        extraSpecialArgs = {
          inherit inputs configPath;
        };
      };
    };
  };
}
