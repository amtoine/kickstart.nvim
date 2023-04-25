return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }

    local telescope = require("telescope")

    telescope.load_extension("projects")

    vim.keymap.set("n", "<leader>pp", function() telescope.extensions.projects.projects{} end, { silent = true, desc = "[p]rojects: open a [p]roject" })
  end
}
