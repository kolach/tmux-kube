#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

# script global variables
kube_config=""

kube_default_config="$HOME/.kube/config"

# icons are set as script global variables
get_config() {
  kube_config=$(get_tmux_option "@kube_config" "$kube_default_config")
}

print_name() {
  local current_context
  current_context=$(grep current < "$kube_config")
  echo "${current_context##*_}"
}

main() {
  get_config
  print_name
}
main
