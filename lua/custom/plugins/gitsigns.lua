return {
  'lewis6991/gitsigns.nvim',
  config = function ()
    local gs = require('gitsigns')

    gs.setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      }
    }

    vim.keymap.set("n", "<leader>ghp", function ()
      gs.prev_hunk()
      gs.preview_hunk_inline()
    end)
    vim.keymap.set("n", "<leader>ghn", function ()
      gs.next_hunk()
      gs.preview_hunk_inline()
    end)
    vim.keymap.set("n", "<leader>ghs", gs.preview_hunk_inline)
    vim.keymap.set("n", "<leader>ghr", gs.reset_hunk)
  end
}
