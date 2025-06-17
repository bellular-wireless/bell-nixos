{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      settings = {
        icons.mappings = true;
        spec = [
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }

          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
          }

          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            mode = [ "n" "v" ];
          }
        ];
      };
      lazyLoad = {
        enable = true;
        settings.event = "VimEnter";
      };
    };
  };
}
