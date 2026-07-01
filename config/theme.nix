{
  config.vim = {
    dashboard.dashboard-nvim.enable = true;
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    # theme = {
    #   enable = true;
    #   base16-colors = {
    #     base00 = "#1B1E28";
    #     base01 = "#303340";
    #     base02 = "#506477";
    #     base03 = "#767C9D";
    #     base04 = "#A6ACCD";
    #     base05 = "#A6ACCD";
    #     base06 = "#E4F0FB";
    #     base07 = "#FFFAC2";
    #     base08 = "#D0679D";
    #     base09 = "#F087BD";
    #     base0A = "#FFFAC2";
    #     base0B = "#5DE4C7";
    #     base0C = "#ADD7FF";
    #     base0D = "#89DDFF";
    #     base0E = "#D0679D";
    #     base0F = "#303340";
    #   };
    #   name = "base16";
    # };

    visuals = {
      nvim-web-devicons = {
        enable = true;
      };
    };

    ui = {
      borders.enable = true;
      colorizer.enable = true;
      # nvim-ufo.enable = true;
    };

    statusline.lualine = {
      enable = true;
      theme = "auto";
      activeSection = {
        z = [
          ''
            {
              require('tmux-status').tmux_windows,
              cond = require('tmux-status').show,
              padding = { left = 3 },
            }
          ''
        ];
      };
      componentSeparator.left = "";
    };
  };
}
