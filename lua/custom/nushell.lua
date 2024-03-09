vim.filetype.add({
    extension = {
        nu = "nu",
        nush = "nu",
        nuon = "nu",
        nushell = "nu",
    },
    pattern = {
        [".*"] = {
            function(_, bufnr)
                local content = vim.filetype.getlines(bufnr, 1)
                if vim.filetype.matchregex(content, [[^#!/usr/bin/env (-S )?nu( --stdin)?]]) then
                    return "nu"
                end
            end,
            priority = -math.huge,
        },
    },
})
