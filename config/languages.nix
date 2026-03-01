{pkgs, ...}: {
  config.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      # autolist = {
      #   package = autolist-nvim;
      #   setup = ''
      #     ft = {
      #         "markdown",
      #         "text",
      #         "tex",
      #         "plaintex",
      #         "norg",
      #     },
      #     require("autolist").setup()
      #   '';
      # };
      markview = {
        package = markview-nvim;
      };
    };

    languages = {
      # OPTIONS
      enableDAP = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      #LANGUAGES
      nix = {
        enable = true;
        lsp = {
          servers = ["nixd"];
        };
        format = {
          enable = true;
          type = ["alejandra"];
        };
        treesitter.enable = true;
      };
      bash = {
        enable = true;
        # format.enable = true;
        treesitter.enable = true;
      };
      css = {
        enable = true;
        treesitter.enable = true;
      };
    };
  };
}
