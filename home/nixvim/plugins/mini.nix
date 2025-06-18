{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.event = "VimEnter";
      };
      modules = {
        ai.n_lines = 500;
        surround = {};
        statusline.use_icons = true;
      };
    };
    #extraConfigLua = ''
    #  require('mini.statusline').section_location = function()
    #    return '%2l:%-2v'
    #  end
    #'';
  };
}
