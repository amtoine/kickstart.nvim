# create a symlink between the current directory and the config
export def setup [] {
    let NVIM_CONFIG = "~/.config/nvim"

    if ($NVIM_CONFIG | path expand | path exists) {
        print $"'($NVIM_CONFIG)' already exists: aborting."
        return
    }

    ln -s (pwd) ($NVIM_CONFIG | path expand)
}

# list the installed plugins
export def plugins [] {
    ls lua/custom/plugins/*lua
    | find --invert init.lua
    | get name
    | path parse
    | get stem
}
