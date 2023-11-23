-- return true if the `value` is inside the `list`, false otherwise
local is_in = function(value, list)
    for _, item in ipairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.cmd.colorscheme("murphy")

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
        local extra_whitespaces = ""

        if is_in(vim.bo.filetype, {"", "aerial", "help", "presenting_markdown", "neo-tree", "git"}) then
            extra_whitespaces = "//"
        else
            extra_whitespaces = "/\\s\\+$\\|\\t/"
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
            args = {"ExtraWhitespace" , extra_whitespaces},
            bang = false,
        }
    end
})

pcall(require, 'custom/nushell')
