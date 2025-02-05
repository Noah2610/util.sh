#!/bin/bash
# Starts REPL with bash and util.sh sourced.

# shellcheck source=./util.sh
source "$( dirname "$0" )/util.sh"

SCRIPT="${ROOT}/$( basename "$0" )"
UTILSH="${ROOT}/util.sh"

function run_repl {
    bash --init-file <( get_initrc ) -i
}

function get_initrc {
    cat <<EOF
HISTFILE="${ROOT}/.repl_history"
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

PS1='[\[\e[38;5;141;1m\]utilsh\[\e[0m\]] \[\e[92m\]\w\[\e[0m\] \$?\n\[\e[1m\]\\$\[\e[0m\] '

set -o vi

source "$UTILSH"

trap '[ \$? = 1 ] && { echo "[exit 1] Restarting repl..."; $SCRIPT; }' EXIT
EOF
}

run_repl
