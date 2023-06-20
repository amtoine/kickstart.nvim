return {
  'rmagatti/goto-preview',
  config = function()
    local goto_preview = require('goto-preview')
    goto_preview.setup {}

    vim.keymap.set("n", "gpd", function() goto_preview.goto_preview_definition() end, { silent = true, desc = "" })
    vim.keymap.set("n", "gpt", function() goto_preview.goto_preview_type_definition() end, { silent = true, desc = "" })
    vim.keymap.set("n", "gpi", function() goto_preview.goto_preview_implementation() end, { silent = true, desc = "" })
    vim.keymap.set("n", "gP", function() goto_preview.close_all_win() end, { silent = true, desc = "" })
    vim.keymap.set("n", "gpr", function() goto_preview.goto_preview_references() end, { silent = true, desc = "" })
  end
}
