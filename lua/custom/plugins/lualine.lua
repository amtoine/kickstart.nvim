return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "wthollingsworth/pomodoro.nvim"
  },
  config = function ()
    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = { left = ">", right = "<" },
      },
      sections = {
        lualine_c = { "filename", require("pomodoro").statusline },
      },
    })
  end
}
