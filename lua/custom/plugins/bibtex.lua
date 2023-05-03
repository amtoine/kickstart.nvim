return {
  "nvim-telescope/telescope-bibtex.nvim",
  requires = {
    {'nvim-telescope/telescope.nvim'},
  },
  config = function ()
    local telescope = require("telescope")

    telescope.load_extension("bibtex")

    vim.keymap.set("n", "<leader>bbt", function() telescope.extensions.bibtex.bibtex{} end, { silent = true, desc = "propose [b]i[bt]ex references for copy" })
  end,
}
