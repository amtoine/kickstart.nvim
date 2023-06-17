return {
    'Lilja/zellij.nvim',
    config = function()
        require('zellij').setup({
            path = "zellij",
            replaceVimWindowNavigationKeybinds = true,
            vimTmuxNavigatorKeybinds = false,
            debug = false,
        })
    end
}
