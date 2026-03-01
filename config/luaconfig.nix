{
  config.vim = {
    luaConfigPre =
      /*
      lua
      */
      ''
        vim.opt.clipboard:append("unnamedplus")
          -- Highlight on yank
          vim.cmd[[
            augroup highlight_yank
                autocmd!
                autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=200 }
            augroup END
          ]]

          -- Save Cursor Position on file, after exiting
          vim.api.nvim_create_autocmd("BufReadPost", {
            desc = "Go To The Last Cursor Position",
            callback = function()
              local last_pos = vim.fn.line("'\"")
              local last_line = vim.fn.line("$")

              if last_pos > 1 and last_pos <= last_line then
                vim.cmd("normal! g`\"")
              end
            end,
          })
      '';

    #luaConfigPost =
    # lua
    #  ''
    #    -- Temp fix tab for cmdline caused by blink
    #    vim.cmd("cunmap <Tab>")
    #  '';
  };
}
