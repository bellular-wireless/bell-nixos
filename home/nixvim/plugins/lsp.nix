{ config, ... }:
{
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
        nil_ls.enable = true;
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
          options.desc = "LSP: [G]oto [D]efinition";
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
