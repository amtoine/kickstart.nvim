vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.cmd.colorscheme("base16-default-dark")

vim.cmd([[
  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  set listchars=tab:>\·,trail:\ ,extends:>,precedes:<,nbsp:+

  " Show problematic characters.
  set list
]])

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    pattern = "*",
    callback = function ()
        if vim.bo.filetype == "" or
           vim.bo.filetype == "aerial" or
           vim.bo.filetype == "help" or
           vim.bo.filetype == "neo-tree"
        then
            return nil
        end

        local color = "darkred"

        vim.cmd {
            cmd = "highlight",
            args = {
                "ExtraWhitespace" ,
                string.format("ctermbg=%s", color),
                string.format("guibg=%s", color)
            },
            bang = false,
        }
        vim.cmd {
            cmd = "match",
            args = {"ExtraWhitespace" , "/\\s\\+$\\|\\t/"},
            bang = false,
        }
    end
})

vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
        nuon = "nu",
    },
    pattern = {
        [".*"] = {
            function(path, bufnr)
                local content = vim.filetype.getlines(bufnr, 1)
                if vim.filetype.matchregex(content, [[^#!/usr/bin/env nu]]) then
                    return "nu"
                end
            end,
            priority = -math.huge,
        },
    },
})
