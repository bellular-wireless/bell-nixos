{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "super-tab";
        appearance.nerd_font_variant = "mono";
        completion.documentation = {
          auto_show = true;
          auto_show_delay_ms = 500;
        };
        sources = {
          default = ["lsp" "path" "snippets" "lazydev" "copilot"];
          providers = {
            lazydev = {
              module = "lazydev.integrations.blink";
              score_offset = 100;
            };
            minuet = {
              name = "minuet";
              module = "minuet.blink";
              async = true;
              timeout_ms = 3000;
              score_offset = 50;
            };
            copilot = {
              async = true;
              module = "blink-cmp-copilot";
              name = "copilot";
              score_offset = 100;
            };
          };
        };
        completion = {
          trigger.prefetch_on_insert = false;
          ghost_text = {
            enabled = true;
            show_without_selection = true;
          };
        };
        fuzzy.prebuilt_binaries.download = true;
        signature.enabled = true;
      };
      lazyLoad = {
        enable = true;
        settings.event = "VimEnter";
      };
    };
    luasnip.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        suggestion.enabled = false;
        panel.enabled = false;
      };
      lazyLoad = {
        enable = true;
        settings.event = "InsertEnter";
      };
    };

    copilot-chat = {
      enable = true;
    };

    blink-cmp-copilot.enable = true;

    minuet = {
      enable = false;
      settings = {
        provider = "openai_fim_compatible";
        n_completions = 1;
        context_window = 512;
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM";
            name = "Ollama";
            stream = false;
            end_point = "http://localhost:11434/v1/completions";
            model = "codellama:7b-code";
            optional = {
              stop = "<EOT>";
              temperature = 0.2;
              context_window = 4096;
              max_tokens = 56;
              top_p = 0.9;
            };
          };
        };
      };
    };
  };
}
