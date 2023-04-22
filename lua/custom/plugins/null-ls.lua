return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function ()
    require("null-ls").setup {
      sources = {
        require("nu-ls"),
      },
    }
  end
}
