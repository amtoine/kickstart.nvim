-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = "-",
        zindex = 20,
      }
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "simrat39/rust-tools.nvim"
    },
    config = function()
      local dap = require('dap')
      local dapui = require("dapui")

      dapui.setup()

      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb'
      }

      local lldb_dap_config = {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
      dap.configurations.cpp = { lldb_dap_config }
      dap.configurations.c = { lldb_dap_config }

      local rust_dap_config = lldb_dap_config
      lldb_dap_config["initCommands"] = function()
        local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

        local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
        local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

        local commands = {}
        local file = io.open(commands_file, 'r')
        if file then
          for line in file:lines() do
            table.insert(commands, line)
          end
          file:close()
        end
        table.insert(commands, 1, script_import)

        return commands
      end
      dap.configurations.rust = { rust_dap_config }

      vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
    end
  },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
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

      vim.keymap.set("n", "<leader>ghp", function()
        gs.prev_hunk()
        gs.preview_hunk_inline()
      end, { silent = true, desc = "[G]itsigns: go to [p]revious [h]unk" })
      vim.keymap.set("n", "<leader>ghn", function()
        gs.next_hunk()
        gs.preview_hunk_inline()
      end, { silent = true, desc = "[G]itsigns: go to [n]ext [h]unk" })
      vim.keymap.set("n", "<leader>ghs", gs.preview_hunk_inline,
        { silent = true, desc = "[G]itsigns: [s]how [h]unk at cursor" })
      vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { silent = true, desc = "[G]itsigns: [r]eset [h]unk at cursor" })
    end
  },

  {
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
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "wthollingsworth/pomodoro.nvim"
    },
    config = function()
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
  },

  { "zioroboco/nu-ls.nvim" },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
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
  },

  { "nvim-treesitter/playground" },

  {
    "justinmk/vim-sneak",
    config = function()
      vim.keymap.set("n", "f", "<Plug>Sneak_f", { desc = "snipe a character" })
      vim.keymap.set("n", "F", "<Plug>Sneak_F", { desc = "snipe a character behind" })
      vim.keymap.set("n", "t", "<Plug>Sneak_t", { desc = "snipe the feet of a character" })
      vim.keymap.set("n", "T", "<Plug>Sneak_T", { desc = "snipe the feet of a character behind" })
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
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true }
      )
    end
  },

  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
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

  { 'echasnovski/mini.nvim', version = '*' },

  { "rbong/vim-flog" },
}
