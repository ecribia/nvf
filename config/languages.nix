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
      # markview = {
      #   package = markview-nvim;
      # };
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
      markdown = {
        enable = true;
        lsp.servers = [
          "markdown-oxide"
        ];
        extensions.markview-nvim = {
          enable = true;
          setupOpts = {
            # markdown.headings = {
            #   heading_1 = {
            #     icon_hl = "@markup.link";
            #     icon = "[%d] ";
            #   };
            #   heading_2 = {
            #     icon_hl = "@markup.link";
            #     icon = "[%d.%d] ";
            #   };
            #   heading_3 = {
            #     icon_hl = "@markup.link";
            #     icon = "[%d.%d.%d] ";
            #   };
            # };
          };
        };
      };
    };
  };
}
