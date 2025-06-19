{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      tabout-nvim
    ];
    extraConfigLua = "require('tabout').setup()";
  };
}
