#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

kube_interpolation=(
	"\#{kube_icon}"
	"\#{kube_name}"
)

kube_commands=(
	"#($CURRENT_DIR/scripts/kube_icon.sh)"
	"#($CURRENT_DIR/scripts/kube_name.sh)"
)

do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#kube_commands[@]}; i++)); do
		all_interpolated=${all_interpolated/${kube_interpolation[$i]}/${kube_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}
