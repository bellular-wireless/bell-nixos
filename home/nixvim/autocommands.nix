{
  programs.nixvim= {
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback = { __raw = "function() vim.hl.on_yank() end"; };
      }
    ];
  };
}
