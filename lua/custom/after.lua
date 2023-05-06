local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.cmd.colorscheme "tokyonight-night"

vim.cmd([[
  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  set listchars=tab:>\·,trail:\ ,extends:>,precedes:<,nbsp:+

  " Show problematic characters.
  set list

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkred guibg=darkred
  match ExtraWhitespace /\s\+$\|\t/
]])

M.nvim_create_augroups{
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    }
}
