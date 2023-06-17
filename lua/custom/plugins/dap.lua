return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "simrat39/rust-tools.nvim"
  },
  config = function()
    local dapui = require("dapui")

    dapui.setup()

    vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
  end
}
