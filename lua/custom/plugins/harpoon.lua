return {
  "theprimeagen/harpoon",

  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file, { silent = true, desc = "[h]arpoon: [a]dd a file to the menu" })
    vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu, { silent = true, desc = "[h]arpoon: toggle menu [e]ntries" })
    vim.keymap.set("n", "<leader>hh", function() ui.nav_file(1) end, { silent = true, desc = "[h]arpoon: go to first item (left [h])" })
    vim.keymap.set("n", "<leader>hj", function() ui.nav_file(2) end, { silent = true, desc = "[h]arpoon: go to second item (down [j])" })
    vim.keymap.set("n", "<leader>hk", function() ui.nav_file(3) end, { silent = true, desc = "[h]arpoon: go to third item (up [k])" })
    vim.keymap.set("n", "<leader>hl", function() ui.nav_file(4) end, { silent = true, desc = "[h]arpoon: go to fourth item (right [l])" })
  end
}
