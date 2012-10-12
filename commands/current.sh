#! /usr/bin/env bash

require 'lib/help.sh'
require 'lib/console.sh'
require 'lib/env.sh'

current_usage() {
	echo "kcm current"
}

current_help() {
	bold "CURRENT HELP"
	echo

	printf '\t'; current_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	Displays the current active environment.  The active environment
	is the environment that links from ~/.chef.
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- None 
"
}

# Print the current kcm environment.
# 
current() {
	if help? $@
	then
		current_help
		exit $?
	fi

	local current="$(env_current)" 
	if [[ -z "$current" ]]
	then
		error "Not using any environment."
		exit 1
	fi

	echo "$current"
}

