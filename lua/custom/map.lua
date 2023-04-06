vim.keymap.set("n", "<leader>so", ":source ~/.config/nvim/init.lua<CR>", { silent = true, desc = "[so]urce the config" })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true, desc = "Remove the search [h]ighlight" })
vim.keymap.set("n", "<leader>t", ":terminal nu<CR>", { silent = true, desc = "Open a [t]erminal with nushell" })

vim.keymap.set("n", "<leader>pf", vim.cmd.Ex, { silent = true, desc = "O[p]en the [f]ile explorer" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { silent = true, desc = "Search for [g]it [f]files" })

-- drag lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "drag visual lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "drag visual lines up" })

-- always stay centered
vim.keymap.set("n", "J", "mzJ`z", { desc = "keep the cursor to the left when merging lines" })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true, desc = "stay vertically centered when scrolling page down" })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true, desc = "stay vertically centered when scrolling pages up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "stay vertically centered when going to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "stay vertically centered when going to previous match" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without overwriting the register" })

-- next greatest remaps ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard only on demand" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank to system clipboard only on demand" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "cut to system clipboard only on demand" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "get out of insert mode with control + C" })

-- move in the code actions lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- misc
vim.keymap.set("n", "Q", "<nop>", { desc = "do not do anything on Q" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format the code with LSP" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
{ desc = "replace all occurences of the work under the cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make the current buffer executable" })

-- a better terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "escape to normal mode in a terminal"})

-- move between any window with `alt` + motion keys
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
