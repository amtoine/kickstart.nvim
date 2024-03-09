#!/usr/bin/env nu
use std log

export def main [
    --runtime: string = "/usr/share/nvim/runtime/"
    --verbose
] {
    let NVIM_CONFIG = "~/.config/nvim" | path expand --no-symlink
    if not ($NVIM_CONFIG | path exists) {
        log info $"aliasing `(pwd)` to `($NVIM_CONFIG)`"
        ln --symbolic (pwd) $NVIM_CONFIG
    } else {
        log warning $"'($NVIM_CONFIG)' already exists: skipping."
    }

    if $env.VIMRUNTIME? == null {
        error make --unspanned { msg: "Please set VIMRUNTIME before running this command." }
    }

    if not ($runtime | path exists) {
        let span = (metadata $runtime | get span)
        error make {
            msg: $"(ansi red_bold)directory_not_found(ansi reset)"
            label: {
                text: "no such directory"
                span: (metadata $runtime).span
            }
        }
    }

    log info $"copying runtime from `($runtime)` to `($env.VIMRUNTIME)`"
    if $verbose {
        sudo cp -rv $runtime $env.VIMRUNTIME
    } else {
        sudo cp -r $runtime $env.VIMRUNTIME
    }

    let owner = $"($env.USER):($env.USER)"
    log info $"changing owner of ($env.VIMRUNTIME) to ($owner)"
    sudo chown -R $owner $env.VIMRUNTIME

    log info $"copying custom Git syntax"
    cp runtime/syntax/git.vim ($env.VIMRUNTIME | path join "syntax" "git.vim")
}
