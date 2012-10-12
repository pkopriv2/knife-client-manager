#! /usr/bin/env bash

export chef_home="${chef_home:-${HOME}/.chef}"

require 'lib/help.sh'
require 'lib/console.sh'

info_usage() {
	echo "kcm info"
}

info_help() {
	bold "INFO HELP"
	echo

	printf '\t'; info_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	Display the knife.rb file for the currently active environment.
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- None 
"
}


# Get the info about the current environment
#
info() {
	if help? $@
	then
		info_help
		exit $?
	fi

	local current=$(env_current)
	if [[ -z $current ]] 
	then 
		error "Not using any environment."
		exit 1
	fi 

	bold "$current:"
	if [[ ! -f  "$chef_home/knife.rb" ]]
	then
		error "This environment has not been configured."
		exit 1
	fi

	cat "$chef_home/knife.rb"
}
