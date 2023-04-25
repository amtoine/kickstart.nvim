return {
  "ThePrimeagen/git-worktree.nvim",
  config = function()
    require("git-worktree").setup {}

    local telescope = require("telescope")
    telescope.load_extension("git_worktree")

    vim.keymap.set("n", "<leader>sgw", function() telescope.extensions.git_worktree.git_worktrees{} end, { silent = true, desc = "[s]witch between [g]it [w]orktrees" })
  end
}
