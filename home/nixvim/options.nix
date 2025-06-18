{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    clipboard.register = "unnamedplus";
    extraPlugins = with pkgs.vimPlugins; [
      citruszest-nvim
      rose-pine
    ];
    colorscheme = "rose-pine";

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;
      list = true;
      cursorline = true;
      scrolloff = 10;
      confirm = true;
      shiftwidth = 2;
      expandtab = true;
    };

    diagnostic.settings = {
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
      underline = {severity = config.lib.nixvim.mkRaw "vim.diagnostic.severity.ERROR";};
      signs.text = config.lib.nixvim.mkRaw ''
        {
          [vim.diagnostic.severity.ERROR] = '󰅚',
          [vim.diagnostic.severity.WARN] = '󰀪',
          [vim.diagnostic.severity.INFO] = '󰋽',
          [vim.diagnostic.severity.HINT] = '󰌶',
        }
      '';
      virtual_text = {
        source = "if_many";
        spacing = 2;
        format = config.lib.nixvim.mkRaw ''
          function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end
        '';
      };
    };

    extraConfigLua = ''
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    '';
  };
}
