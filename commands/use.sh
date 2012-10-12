#! /usr/bin/env bash

export kcm_home=${kcm_home:-${HOME}/.kcm}
export kcm_env_home=${kcm_env_home:-$kcm_home/env}
export chef_home="${chef_home:-${HOME}/.chef}"

require 'lib/help.sh'
require 'lib/console.sh'
require 'lib/env.sh'

use_usage() {
	echo "kcm use <environment>"
}

use_help() {
	bold "USE HELP"
	echo

	printf '\t'; use_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	Make the given environment the *active* environment.  This amounts 
	to creating a symbolic link from ~/.chef to the environment directory.
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- environment The environment to use. 
"
}

# Set a kcm environment as the one currently 
# being used.
# 
use() {
	if help? $@
	then
		use_help
		exit $?
	fi

	if (( $# != 1 ))
	then
		error "Invalid use of use."
		echo

		use_usage
		exit 1
	fi

	if [[ -z "$1" ]] 
	then
		error "Must supply an environment."
		exit 1
	fi

	if ! env_exists "$1"
	then
		error "That knife environment [$1] does not exist."
		exit 1
	fi

	env_unuse

	env_use "$1" 
	info "Now using knife environment: $1"
}
