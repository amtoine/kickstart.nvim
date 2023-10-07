vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
        nuon = "nu",
    },
    pattern = {
        [".*"] = {
            function(path, bufnr)
                local content = vim.filetype.getlines(bufnr, 1)
                if vim.filetype.matchregex(content, [[^#!/usr/bin/env nu]]) then
                    return "nu"
                end
            end,
            priority = -math.huge,
        },
    },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.nu = {
  install_info = {
    url = "https://github.com/nushell/tree-sitter-nu",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "nu",
}
