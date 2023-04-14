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
    end, { silent = true, desc = "[G]itsigns: go to [p]revious [h]unk" })
    vim.keymap.set("n", "<leader>ghn", function ()
      gs.next_hunk()
      gs.preview_hunk_inline()
    end, { silent = true, desc = "[G]itsigns: go to [n]ext [h]unk" })
    vim.keymap.set("n", "<leader>ghs", gs.preview_hunk_inline, { silent = true, desc = "[G]itsigns: [s]how [h]unk at cursor" })
    vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { silent = true, desc = "[G]itsigns: [r]eset [h]unk at cursor" })
  end
}
