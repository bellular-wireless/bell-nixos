{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "super-tab";
        appearance.nerd_font_variant = "mono";
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 500;
        };
        sources = {
          default = ["lsp" "path" "snippets" "lazydev"];
          providers = {
            lazydev = {
              module = "lazydev.integrations.blink";
              score_offset = 100;
            };
          };
        };
        fuzzy.prebuilt_binares.download = true;
        signature.enabled = true;
      };
      lazyLoad = {
        enable = true;
        settings.event = "VimEnter";
      };
    };
    luasnip.enable = true;
  };
}
