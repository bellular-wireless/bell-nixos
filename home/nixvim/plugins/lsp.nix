{
  config,
  configPath,
  host,
  user,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lazydev = {
        enable = true;
        settings = {
          library = [
            "path = \"\${3rd}/luv/library\""
            "words = \"vim%.uv\""
          ];
        };
      };

      lspconfig.enable = true;
      fidget.enable = true;
    };

    lsp = {
      inlayHints.enable = true;

      servers = {
        lua_ls = {
          enable = true;
          settings.Lua.completion.callSnippet = "Replace";
        };
        nixd = {
          enable = true;
          settings = {
            cmd = config.lib.nixvim.mkRaw "{ \"nixd\" }";
            settings = {
              nixd = {
                nixpkgs.expr = "import <nixpkgs> { }";
                options = {
                  nixos.expr = "(builtins.getFlake \"${configPath}\").nixosConfigurations.${host}.options";
                  home_manager.expr = "(builtins.getFlake \"${configPath}\").homeConfigurations.${user}.options";
                };
              };
            };
          };
        };
        gopls.enable = true;
        htmx.enable = true;
        html.enable = true;
        tailwindcss.enable = true;
        templ.enable = true;
        docker_compose_language_service.enable = true;
        #nil_ls.enable = true;
      };

      keymaps = [
        {
          key = "grn";
          lspBufAction = "rename";
          options.desc = "LSP: [R]e[n]ame";
        }

        {
          key = "gra";
          lspBufAction = "code_action";
          options.desc = "LSP: [G]oto Code [A]ction";
        }

        {
          key = "grr";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_references";
          options.desc = "LSP: [G]oto [R]eferences";
        }

        {
          key = "gri";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_implementations";
          options.desc = "LSP: [G]oto [I]mplementation";
        }

        {
          key = "grd";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
          options.desc = "LSP: [G]oto [D]definition";
        }

        {
          key = "grD";
          lspBufAction = "declaration";
          options.desc = "LSP: [G]oto [D]eclaration";
        }

        {
          key = "gO";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_document_symbols";
          options.desc = "LSP: Open Document Symbols";
        }

        {
          key = "gW";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_dynamic_workspace_symbols";
          options.desc = "LSP: Open Workspace Symbols";
        }

        {
          key = "grt";
          action = config.lib.nixvim.mkRaw "require('telescope.builtin').lsp_type_definitions";
          options.desc = "LSP: [G]oto [T]ype Definition";
        }
      ];
    };
  };
}
