use std log

# create a symlink between the current directory and the config
export def setup [] {
    install-queries

    let NVIM_CONFIG = "~/.config/nvim" | path expand --no-symlink

    if ($NVIM_CONFIG | path exists) {
        print $"'($NVIM_CONFIG)' already exists: aborting."
        return
    }

    ln -s (pwd) $NVIM_CONFIG
}

export def "install runtime" [
    --runtime: string = "/usr/share/nvim/runtime/"
    --user: string
    --group: string
    --verbose
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
