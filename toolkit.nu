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

def pretty-cmd [] {
    let cmd = $in
    $"(ansi -e {fg: default attr: di})($cmd)(ansi reset)"

}

export def import-git-projects [] {
    let projects = ($env.HOME | path join ".local/share/nvim/project_nvim/project_history")

    let before = ($projects | open | lines | length)

    $projects | open | lines | append (
        ghq list
        | lines
        | each {|it|
            print $"adding (ansi yellow)($it)(ansi reset) to the projects..."
            ghq root | str trim | path join $it
        }
    ) | uniq
    | save -f $projects

    print $"all ('git' | pretty-cmd) projects (ansi green_bold)successfully added(ansi reset) to the ('projects.nvim' | pretty-cmd) list!"
    print $"from ($before) to ($projects | open | lines | length) projects."
}
