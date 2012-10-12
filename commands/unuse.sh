#! /usr/bin/env bash

export chef_home="${chef_home:-${HOME}/.chef}"

require 'lib/help.sh'
require 'lib/console.sh'
require 'lib/env.sh'

unuse_usage() {
	echo "kcm unuse"
}

unuse_help() {
	bold "UNUSE HELP"
	echo

	printf '\t'; unuse_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	Make it so there is no *active* environment.  This amounts to
	deleting the link from ~/.chef
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- None 
"
}

# Don't use any kcm environments
# 
unuse() {
	if help? $@
	then
		unuse_help
		exit $?
	fi

	env_unuse
}

