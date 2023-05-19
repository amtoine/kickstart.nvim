return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function ()
    require("null-ls").setup {
      sources = {
        require("nu-ls").setup({
          methods = {
            "diagnostics_on_open",
            "diagnostics_on_save",
            "hover",
          },
        })
      },
    }
  end
}
