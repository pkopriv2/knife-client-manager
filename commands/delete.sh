#! /usr/bin/env bash

export kcm_env_home=${kcm_env_home:-$kcm_home/env}

require 'lib/help.sh'
require 'lib/console.sh'
require 'lib/env.sh'

delete_usage() {
	echo "kcm delete <environment>"
}

delete_help() {
	bold "DELETE HELP"
	echo

	printf '\t'; delete_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	Deletes an existing environment.
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- environment The environment to delete.
"
}

# Delete a kcm environment.
# 
delete() {
	if help? $@
	then
		delete_help
		exit $?
	fi

	if (( $# != 1 ))
	then
		error "Invalid use of delete."
		echo

		delete_usage
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

	printf "Deleting environment [$1]. Are you sure (y|n):" 
	read answer

	if [[ "$answer" != "y" ]] 
	then
		echo "Aborted"
		exit 0
	fi

	env_unuse

	info "Deleting: $1"
	env_delete "$1"
	info "Done."
}

