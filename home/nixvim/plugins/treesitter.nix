{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight = {
        enable = true;
        #enable if there's problems with indenting or something
        #additional_vim_regex_highlighting = [ 'ruby' ];
      };
      indent = {
        enable = true;
      };
    };
  };
}
