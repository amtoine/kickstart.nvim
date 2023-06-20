return {
  "f-person/git-blame.nvim",
  config = function ()
    vim.g.gitblame_display_virtual_text = 0

    vim.keymap.set("n", "<leader>gbt", ":GitBlameToggle<CR>")
    vim.keymap.set("n", "<leader>gbc", ":GitBlameCopySHA<CR>")
  end
}
