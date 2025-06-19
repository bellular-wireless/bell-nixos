{
  imports = [
    ./which-key.nix
    ./gitsigns.nix
    ./telescope.nix
    ./lsp.nix
    ./autocompletion.nix
    ./conform.nix
    ./mini.nix
    ./treesitter.nix
    ./tabout.nix
  ];

  programs.nixvim.plugins = {
    sleuth.enable = true;
    lz-n.enable = true;
    web-devicons.enable = true;
    todo-comments = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.event = "VimEnter";
      };
      settings = {
        signs = false;
      };
    };
    nvim-autopairs = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.event = "InsertEnter";
      };
    };
    comment.enable = true;
  };
}
