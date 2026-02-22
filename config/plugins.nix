{pkgs, ...}: let
  tmux-status = pkgs.vimUtils.buildVimPlugin {
    name = "tmux-status";
    src = pkgs.fetchFromGitHub {
      owner = "christopher-francisco";
      repo = "tmux-status.nvim";
      rev = "18268e1044eff72dab201069204b402ee4d09bda";
      hash = "sha256-1qGvLaKgRA0CXldx5k+/3y3Q4ypGs1CwcAPfoenxod8=";
    };
  };

  nordic-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nordic-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "AlexvZyl";
      repo = "nordic.nvim";
      rev = "6afe957722fb1b0ec7ca5fbea5a651bcca55f3e1";
      hash = "sha256-NY4kjeq01sMTg1PZeVVa2Vle4KpLwWEv4y34cDQ6JMU=";
    };
  };

  mellow-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "mellow.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mellow-theme";
      repo = "mellow.nvim";
      rev = "3894d0d3238a8941f242b88baf3d1cbdb447282e";
      hash = "sha256-adj0UlnbVxIBVoISxM50rVpXP5QoxF0Op0oBr6hdrRU=";
    };
  };

  golf = pkgs.vimUtils.buildVimPlugin {
    name = "golf";
    src = pkgs.fetchFromGitHub {
      owner = "vuciv";
      repo = "golf";
      rev = "abf1bc0c1c4a5482b4a4b36b950b49aaa0f39e69";
      hash = "sha256-lCzt+7/uZ/vvWnvWPIqjtS3G3w3qOhI7vHdSQ9bvMKU=";
    };
  };
  # direnv-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "direnv-nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "actionshrimp";
  #     repo = "direnv.nvim";
  #     rev = "eec36a38285457c4e5dea2c6856329a9a20bd3a4";
  #     hash = "sha256-7NcVskgAurbIuEVIXxHvXZfYQBOEXLURGzllfVEQKNE=";
  #   };
  # };
in {
  config.vim = {
    lazy.plugins.vimtex = {
      enabled = true;
      package = pkgs.vimPlugins.vimtex;
      lazy = true;
      ft = "tex";
      setupOpts = {
        init = ''
          vim.g.vimtex_view_method = "general"
          vim.g.vimtex_view_general_viewer = "zathura"
          vim.g.vimtex_compiler_method = "latexrun"
        '';
      };
      # Added this
      after = ''
        vim.api.nvim_command('unlet b:did_ftplugin')
        vim.api.nvim_command('call vimtex#init()')
      '';
    };
    extraPlugins = with pkgs.vimPlugins; {
      telescope-file-browser = {
        package = telescope-file-browser-nvim;
      };

      tmux-status = {
        package = tmux-status;
        setup = ''
          require('tmux-status').setup {opts = {}}
        '';
      };

      mellow-nvim = {
        package = mellow-nvim;
        setup =
          /*
          lua
          */
          ''
            vim.cmd.colorscheme('mellow')
          '';
      };

      neogit = {
        package = neogit;
        setup = "require('neogit').setup {}";
      };

      oil = {
        package = oil-nvim;
        setup = "require('oil').setup {}";
      };

      # poimandres-nvim = {
      #   package = poimandres-nvim;
      #   setup =
      #     /*
      #     lua
      #     */
      #     ''
      #       vim.cmd.colorscheme ('poimandres')
      #     '';
      # };

      suda = {
        package = vim-suda;
      };

      colorizer = {
        package = nvim-colorizer-lua;
        setup = "require('colorizer').setup {}";
      };

      nui-nvim = {
        package = nui-nvim;
      };

      neogen = {
        package = neogen;
        setup = "require('neogen').setup {}";
      };

      flash-nvim = {
        package = flash-nvim;
      };

      diffview-nvim = {
        package = diffview-nvim;
      };

      plenary = {
        package = plenary-nvim;
      };

      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup {}";
      };

      golf = {
        package = golf;
      };

      vim-rooter = {
        package = vim-rooter;
        setup = ''
          vim.g.rooter_patterns = {'>.config', '.git', '.ozz', 'index.md', '>Documents', '>rPiPico', '>Pico', '=home-manager', 'flake.nix', '*.norg'}
        '';
      };

      tabby = {
        package = tabby-nvim;
        setup =
          /*
          lua
          */
          ''
            local theme = {
              fill = "TabLineFill",
              -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
              head = "TabLine",
              current_tab = { fg = "#181825", bg = "#cdd6f4" },
              tab = "TabLine",
              win = { fg = "#181825", bg = "#f5e0dc" },
              tail = "TabLine",
            }
            require("tabby.tabline").set(function(line)
              return {
                {
                  { "  ", hl = theme.head },
                  line.sep("", theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                  local hl = tab.is_current() and theme.current_tab or theme.tab
                  return {
                    line.sep("", hl, theme.fill),
                    tab.is_current() and "" or "",
                    tab.number(),
                    tab.close_btn(""),
                    line.sep("", hl, theme.fill),
                    hl = hl,
                    margin = " ",
                  }
                end),
              }
            end)
          '';
      };
    };
    # lazy.plugins = {
    #   orgmode = {
    #     package = "orgmode";
    #     cmd = ["BufEnter *.org"];
    #   };
    # };
  };
}
