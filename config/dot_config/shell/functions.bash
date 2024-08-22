#!/usr/bin/env bash
# shellcheck disable=SC2015
# =========================================================================================
# Chezmoi Setup
#
# @date 17.3.2023
# @author Gabriel Nützi, gnuetzi@gmail.com
# =========================================================================================
SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" &>/dev/null && pwd)
if [ ! -f "$SCRIPT_DIR" ]; then
    SCRIPT_DIR="$HOME/.config/shell"
fi

. "$SCRIPT_DIR/common/log.sh" || {
    echo "Could not source 'log.sh'."
} >&2
