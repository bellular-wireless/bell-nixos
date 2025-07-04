{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      stylua
      alejandra
      codespell
    ];
    plugins.conform-nvim = {
      enable = true;
      #     lazyLoad = {
      #       enable = true;
      #       settings = {
      #         event = "BufWritePre";
      #         cmd = "ConformInfo";
      #       };
      #     };
      settings = {
        notify_on_error = true;
        format_on_save = ''
          function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
              return nil
            else
              return {
                timeout_ms = 500,
                lsp_format = 'fallback',
              }
            end
          end
        '';
        formatters_by_ft = {
          lua = ["stylua"];
          nix = ["alejandra"];
          templ = ["templ"];
          go = ["gofmt"];
          "*" = ["codespell"];
        };
      };
    };
  };
}
