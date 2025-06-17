{
  imports = [
    ./which-key.nix
    ./gitsigns.nix
    ./telescope.nix
  ];
  programs.nixvim.plugins = {
    sleuth.enable = true;
    lz-n.enable = true;
    web-devicons.enable = true;
  };
}
