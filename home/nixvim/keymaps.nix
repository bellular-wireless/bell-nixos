{config, ...}: let
  mkCmd = cmd: "<cmd>${cmd}<CR>";
in {
  programs.nixvim = {
    keymaps = [
      {
        mode = ["n"];
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options = {
          desc = "Clear highlights on search when pressing <Esc> in normal mode";
        };
      }

      {
        mode = ["n"];
        key = "<leader>q";
        action = config.lib.nixvim.mkRaw "require('telescope.builtin').diagnostics";
        options = {
          desc = "Open diagnostic [Q]uickfix list";
        };
      }

      {
        mode = ["t"];
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }

      {
        mode = ["n"];
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }

      {
        mode = ["n"];
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }

      {
        mode = ["n"];
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }

      {
        mode = ["n"];
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }

      {
        mode = "n";
        key = "<leader>/";
        action.__raw = ''
          function()
            require('telescope.builtin').current_buffer_fuzzy_find(
                require('telescope.themes').get_dropdown {
                  winblend = 10,
                  previewer = false
                }
              )
            end
        '';
        options = {
          desc = "[/] Fuzzily search in current buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>s/";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files'
            }
          end
        '';
        options = {
          desc = "[S]earch [/] in Open Files";
        };
      }
      {
        mode = "";
        key = "<leader>f";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options = {
          desc = "[F]ormat buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>r";
        action = mkCmd "NvimTreeFocus";
        options.desc = "Toggle File T[r]ee";
      }
      {
        mode = "n";
        key = "s";
        action = "<Nop>";
        options.silent = true;
      }
      {
        mode = "v";
        key = "<C-Down>";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "<C-Up>";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "n";
        key = "<leader>c";
        action = mkCmd "CopilotChat";
        options.desc = "[C]opilot Chat";
      }
    ];
  };
}
