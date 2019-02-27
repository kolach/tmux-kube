#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

# script global variables
kube_icon=""

kube_default_icon="⎈"

# icons are set as script global variables
get_icon_settings() {
  kube_icon=$(get_tmux_option "@kube_icon" "$kube_default_icon")
}

main() {
  get_icon_settings
  echo "$kube_icon"
}
main
