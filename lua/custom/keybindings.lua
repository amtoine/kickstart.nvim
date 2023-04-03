vim.keymap.set('n', '<leader>so', ':source ~/.config/nvim/init.lua<CR>', { silent = true, desc = "[so]urce the config" })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true, desc = "Remove the search [h]ighlight" })
vim.keymap.set('n', '<leader>t', ':terminal nu<CR>', { silent = true, desc = "Open a [t]erminal with nushell" })
vim.keymap.set('n', '<c-d>', '<c-d>zz', { silent = true })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { silent = true })

vim.keymap.set('n', '<leader>pf', vim.cmd.Ex, { silent = true, desc = 'O[p]en the [f]ile explorer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { silent = true, desc = 'Search for [g]it [f]files' })
