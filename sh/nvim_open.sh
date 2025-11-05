#!/bin/bash

# nvim shortcut, that does cd first, to allow for harpoon to detect project directory correctly
# e stands for editor
#NB: $1 nvim arg has to be the path
e() {
    nvim_commands=""
    if [ "$1" = "--flag_load_session" ]; then
        nvim_commands="-c SessionLoad"
        shift
    fi
    nvim_evocation="nvim"
    if [ "$1" = "--use_sudo_env" ]; then
        nvim_evocation="sudo -Es -- nvim"
        shift
    fi
    local full_command="${nvim_evocation} ."
    if [ -n "$1" ]; then
        if [ -d "$1" ]; then
            pushd "$1" >/dev/null 2>&1
            shift
            full_command="${nvim_evocation} ${@} ."
        else
            local try_extensions=("" ".sh" ".rs" ".go" ".py" ".json" ".txt" ".md" ".typ" ".tex" ".html" ".js" ".toml" ".conf")
            for ((i=0; i<${#try_extensions[@]}; i++)); do
                local try_path="${1}${try_extensions[$i]}"
                if [ -f "$try_path" ]; then
                    pushd "$(dirname "$try_path")" >/dev/null 2>&1
                    shift
                    full_command="${nvim_evocation} $(basename "$try_path") ${@} ${nvim_commands}"
                    eval "${full_command}"
                    popd >/dev/null 2>&1
                    return 0
                fi
            done
            full_command="${nvim_evocation} ${@}"
        fi
    fi

    full_command+=" ${nvim_commands}"
    eval "${full_command}"

    while [ "$(dirs -v | wc -l)" -gt 1 ]; do popd; done >/dev/null 2>&1
}
e "${@}"
