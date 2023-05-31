return {
  "justinmk/vim-sneak",
  config = function ()
    vim.keymap.set("n", "f", "<Plug>Sneak_f", { desc = "snipe a character" })
    vim.keymap.set("n", "F", "<Plug>Sneak_F", { desc = "snipe a character behind" })
    vim.keymap.set("n", "t", "<Plug>Sneak_t", { desc = "snipe the feet of a character" })
    vim.keymap.set("n", "T", "<Plug>Sneak_T", { desc = "snipe the feet of a character behind" })
  end
}
