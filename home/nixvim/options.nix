{ pkgs, ... }:
{
  programs.nixvim = {
    clipboard.register = "unnamedplus";
    extraPlugins = with pkgs.vimPlugins; [
      citruszest-nvim
    ];
    colorscheme = "citruszest";

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
    };

    extraConfigLua = ''
	vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    '';
  };
}
