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
    luaConfigPost =
      /*
      lua
      */
      ''
        -- []() markdown link: go-to or create file
        local function md_link_target()
          local line = vim.api.nvim_get_current_line()
          local col  = vim.api.nvim_win_get_cursor(0)[2] + 1
          local s = 1
          while true do
            local ls, le, _, target = line:find("%[([^%]]*)%]%(([^%)]+)%)", s)
            if not ls then break end
            if col >= ls and col <= le then
              local path = (target:match("^([^#?]+)") or target):match("^%s*(.-)%s*$")
              return path
            end
            s = le + 1
          end
        end

        local function open_or_create(link_path)
          if link_path:match("^https?://") then
            vim.notify("[md-link] External URL, skipping", vim.log.levels.WARN)
            return
          end
          local full
          if link_path:sub(1,1) == "/" then
            full = link_path
          else
            full = vim.fn.fnamemodify(vim.fn.expand("%:p:h") .. "/" .. link_path, ":p")
          end
          if not full:match("%.[^/]+$") then full = full .. ".md" end
          if vim.fn.filereadable(full) == 0 then
            local dir = vim.fn.fnamemodify(full, ":h")
            if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
            local f = io.open(full, "w")
            if f then
              f:write("# " .. vim.fn.fnamemodify(full, ":t:r"):gsub("[-_]", " ") .. "\n")
              f:close()
            end
            vim.notify("[md-link] Created " .. full, vim.log.levels.INFO)
          end
          vim.cmd("edit " .. vim.fn.fnameescape(full))
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern  = { "markdown" },
          callback = function()
            vim.keymap.set("n", "gd", function()
              local t = md_link_target()
              if t then open_or_create(t) else vim.lsp.buf.definition() end
            end, { buffer = true, silent = true, noremap = true,
                   desc = "[]() go-to/create or LSP definition" })
          end,
        })

        -- Custom foldtext for markdown headings (org-mode style)
        local function custom_foldtext()
          local foldstart = vim.v.foldstart
          local line = vim.fn.getline(foldstart)
          local level = #(line:match("^#+") or "#")
          local text = line:gsub("^#+%s*", "")

          local ok, spec = pcall(require, "markview.spec")
          local icon = ""
          if ok then
            local heading_conf = spec.get({ "markdown", "headings", "heading_" .. level }, { fallback = {} })
            if heading_conf and heading_conf.icon then
              if type(heading_conf.icon) == "string" then
                icon = heading_conf.icon
              elseif type(heading_conf.icon) == "function" then
                local success, result = pcall(heading_conf.icon, nil, { levels = { level } })
                icon = success and result or ""
              end
            end
          end

          local indent = string.rep(" ", level - 1)
          return indent .. icon .. text .. "  ▼"
        end

        _G.custom_foldtext = custom_foldtext
        vim.opt.foldtext = "v:lua.custom_foldtext()"
        vim.opt.fillchars:append({ fold = " " })

        -- Tab fold
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "markdown",
          callback = function(args)
            local function is_heading()
              local line = vim.api.nvim_get_current_line()
              return line:match("^#+%s") ~= nil
            end

            local function fallback_tab()
              local global_maps = vim.api.nvim_get_keymap("n")
              for _, map in ipairs(global_maps) do
                if map.lhs == "<Tab>" or map.lhs == "\t" then
                  if map.callback then
                    map.callback()
                    return
                  elseif map.rhs and map.rhs ~= "" then
                    local keys = vim.api.nvim_replace_termcodes(map.rhs, true, true, true)
                    vim.api.nvim_feedkeys(keys, "n", false)
                    return
                  end
                end
              end
              -- no global mapping found, send raw Tab
              local keys = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end

            vim.keymap.set("n", "<Tab>", function()
              if is_heading() then
                pcall(vim.cmd, "normal! za")
              else
                fallback_tab()
              end
            end, { buffer = args.buf, silent = true, desc = "Fold heading or fallback Tab" })
          end,
        })

        -- Daily Notes for Markdown Oxide
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == "markdown-oxide" then
              vim.api.nvim_create_user_command(
                "Daily",
                function(cmd_args)
                  local input = cmd_args.args
                  local arguments = (input ~= "" ) and { input } or {}
                  client:exec_cmd({
                    command = "jump",
                    arguments = arguments,
                  })
                end,
                { desc = "Open daily note", nargs = "*" }
              )
            end
          end,
        })
      '';
  };
}
