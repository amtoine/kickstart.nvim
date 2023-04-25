# create a symlink between the current directory and the config
export def setup [] {
    let NVIM_CONFIG = ("~/.config/nvim" | path expand --no-symlink)

    if ($NVIM_CONFIG | path exists) {
        print $"'($NVIM_CONFIG)' already exists: aborting."
        return
    }

    ln -s (pwd) $NVIM_CONFIG
}

# list the installed plugins
export def plugins [] {
    ls lua/custom/plugins/*lua
    | find --invert init.lua
    | get name
    | path parse
    | get stem
}

export def import-git-projects [] {
    ghq list
    | lines
    | each {|it| ghq root | str trim | path join $it}
    | to text
    | save -f ~/.local/share/nvim/project_nvim/project_history
}
