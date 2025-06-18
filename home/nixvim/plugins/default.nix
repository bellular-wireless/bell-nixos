{
  imports = [
    ./which-key.nix
    ./gitsigns.nix
    ./telescope.nix
    ./lsp.nix
    ./autocompletion.nix
    ./conform.nix
    ./mini.nix
  ];
  programs.nixvim.plugins = {
    sleuth.enable = true;
    lz-n.enable = true;
    web-devicons.enable = true;
  };
}
