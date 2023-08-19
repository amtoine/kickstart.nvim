use std log

def install-queries [] {
    let remote = "https://raw.githubusercontent.com/nushell/tree-sitter-nu/main/queries/"
    let local = (
        $env.XDG_DATA_HOME?
        | default ($env.HOME | path join ".local" "state")
        | path join "nvim" "lazy" "nvim-treesitter" "queries" "nu"
    )

    let file = "highlights.scm"

    mkdir $local
    http get ([$remote $file] | str join "/") | save --force ($local | path join $file)

    print $"($file) pulled."
}

# create a symlink between the current directory and the config
export def setup [] {
    install-queries

    let NVIM_CONFIG = ("~/.config/nvim" | path expand --no-symlink)

    if ($NVIM_CONFIG | path exists) {
        print $"'($NVIM_CONFIG)' already exists: aborting."
        return
    }

    ln -s (pwd) $NVIM_CONFIG
}

export def update [] {
    install-queries
    nvim -c ":TSUpdate"
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

    mkdir ($projects | path dirname)
    touch $projects

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

export def "install runtime" [
    --runtime: string = "/usr/share/nvim/runtime/"
    --user: string
    --group: string
    --verbose: bool
] {
    if $env.VIMRUNTIME? == null {
        error make --unspanned { msg: "Please set VIMRUNTIME before running this command." }
    }

    if not ($runtime | path exists) {
        let span = (metadata $runtime | get span)
        error make {
            msg: $"(ansi red_bold)directory_not_found(ansi reset)"
            label: {
                text: "no such directory"
                start: $span.start
                end: $span.end
            }
        }
    }

    let user = $user | default $env.USER
    let group = $group | default $env.USER

    log info $"copying runtime from ($runtime) to ($env.VIMRUNTIME)"
    if $verbose {
        sudo cp -rv $runtime $env.VIMRUNTIME
    } else {
        sudo cp -r $runtime $env.VIMRUNTIME
    }

    let owner = $"($user):($group)"
    log info $"changing owner of ($env.VIMRUNTIME) to ($owner)"
    sudo chown -R $owner $env.VIMRUNTIME

    log info $"copying custom Git syntax"
    cp runtime/syntax/git.vim ($env.VIMRUNTIME | path join "syntax" "git.vim")
}
