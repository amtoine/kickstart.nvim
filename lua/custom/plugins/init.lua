-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- language support
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 5,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = "-",
        zindex = 20,
      }
      vim.keymap.set("n", "<leader>ct", ":TSContextToggle<CR>", { silent = true, desc = "Toggle the context" })
      vim.keymap.set("n", "<leader>cu", function()
        require("treesitter-context").go_to_context()
      end, { silent = true, desc = "Go up in the context" })
    end
  },

  {
    'rmagatti/goto-preview',
    config = function()
      local goto_preview = require('goto-preview')
      goto_preview.setup {}

      vim.keymap.set("n", "<leader>gpd", function() goto_preview.goto_preview_definition() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpt", function() goto_preview.goto_preview_type_definition() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpi", function() goto_preview.goto_preview_implementation() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gP", function() goto_preview.close_all_win() end, { silent = true, desc = "" })
      vim.keymap.set("n", "<leader>gpr", function() goto_preview.goto_preview_references() end, { silent = true, desc = "" })
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("trouble").setup {
        icons = true,
      }

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true }
      )
    end
  },

  {
    "nvim-telescope/telescope-bibtex.nvim",
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("bibtex")

      vim.keymap.set("n", "<leader>bbt", function() telescope.extensions.bibtex.bibtex {} end,
        { silent = true, desc = "propose [b]i[bt]ex references for copy" })
    end,
  },

  { "lervag/vimtex" },

  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require('aerial').setup({
        on_attach = function(bufnr)
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end
      })
      vim.keymap.set('n', '<leader>at', ':AerialToggle!<CR>')
    end
  },

  { "nvim-treesitter/playground" },

  -- Git
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup({})

      vim.keymap.set("n", "<leader>gg", neogit.open, { silent = true, desc = "" })
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
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

      vim.keymap.set("n", "<leader>ghp", gs.prev_hunk , { silent = true, desc = "[G]itsigns: go to [p]revious [h]unk" })
      vim.keymap.set("n", "<leader>ghn", gs.next_hunk , { silent = true, desc = "[G]itsigns: go to [n]ext [h]unk" })
      vim.keymap.set("n", "<leader>ghs", gs.preview_hunk_inline, { silent = true, desc = "[G]itsigns: [s]how [h]unk at cursor" })
      vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { silent = true, desc = "[G]itsigns: [r]eset [h]unk at cursor" })
    end
  },

  { "rbong/vim-flog" },

  -- motion in space and time
  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>ha", mark.add_file, { silent = true, desc = "[h]arpoon: [a]dd a file to the menu" })
      vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu,
        { silent = true, desc = "[h]arpoon: toggle menu [e]ntries" })
      vim.keymap.set("n", "<leader>hh", function() ui.nav_file(1) end,
        { silent = true, desc = "[h]arpoon: go to first item (left [h])" })
      vim.keymap.set("n", "<leader>hj", function() ui.nav_file(2) end,
        { silent = true, desc = "[h]arpoon: go to second item (down [j])" })
      vim.keymap.set("n", "<leader>hk", function() ui.nav_file(3) end,
        { silent = true, desc = "[h]arpoon: go to third item (up [k])" })
      vim.keymap.set("n", "<leader>hl", function() ui.nav_file(4) end,
        { silent = true, desc = "[h]arpoon: go to fourth item (right [l])" })
    end
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- misc
  {
    "laytan/cloak.nvim",
    config = function()
      require('cloak').setup({
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        cloak_length = nil,
        patterns = {
          {
            file_pattern = '.env*',
            cloak_pattern = { '=.+', ':.+', '-.+' }
          },
        },
      })
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {},
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = ">", right = "<" },
        },
        sections = {
          lualine_c = { "filename" },
        },
      })
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("todo-comments").setup {}

      vim.keymap.set("n", "<leader>tc", ":TodoTelescope<CR>")
    end
  },

  { "folke/twilight.nvim" },

  { "christoomey/vim-tmux-navigator" },

  { "rebelot/kanagawa.nvim" },

  { "KilianVounckx/nvim-tetris", commit = "3a791b74bbee29e2e4452d2776415de4f3f3e08b" },
}
