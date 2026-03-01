{
  config.vim = {
    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };

    minimap = {
      minimap-vim.enable = false;
      # codewindow.enable = true; # lighter, faster, and uses lua for configuration (CAUSES ERROR IN FEB 2026)
    };

    utility = {
      surround = {
        enable = true;
        setupOpts.keymaps = {
          change = "cs";
        };
      };
    };

    vimAlias = false;
    # useSystemClipboard = true;
    undoFile.enable = true;

    options = {
      backup = false;
      # completeopt = ''{ "menuone", "noselect" }'';
      conceallevel = 0;
      fileencoding = "utf-8";
      hidden = true;
      ignorecase = true;
      mouse = "a";
      pumheight = 8;
      pumblend = 10;
      showmode = false;
      smartcase = true;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      swapfile = true;
      timeoutlen = 500;
      updatetime = 250;
      writebackup = false;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      cursorline = true;
      number = true;
      relativenumber = true;
      numberwidth = 4;
      signcolumn = "yes";
      wrap = true;
      scrolloff = 8;
      sidescrolloff = 8;
      lazyredraw = true;
      termguicolors = true;
      # spelllang= "en,cjk,";
    };
  };
}
