#! /usr/bin/env bash

require 'lib/help.sh'
require 'lib/console.sh'
require 'lib/env.sh'

create_usage() {
	echo "kcm create <environment>"
}

create_help() {
	bold "CREATE HELP"
	echo

	printf '\t'; create_usage
	echo

	bold "DESCRIPTION"

	printf "%s\n" "
	Creates a new environment.
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- environment  The environment to create.  Must include only characters 
	               of: [a-zA-Z0-9-]
"
}

create() {
	if help? "$@"
	then
		create_help
		exit $?
	fi

	if (( $# != 1 ))
	then
		error "Invalid use of create."
		echo

		create_usage
		exit 1
	fi

	if [[ -z "$1" ]] 
	then
		error "Must supply an environment."
		exit 1
	fi

	if ! echo $1 | grep -q '^[a-zA-Z0-9\-]\+$'
	then
		error "Environments can only contain [a-zA-Z0-9-]"
		exit 1
	fi

	if env_exists "$1"
	then
		error "That knife environment already exists."
		exit 1
	fi
	
	env_unuse

	mkdir "$kcm_env_home/$1"
	info "Successfully created knife environment: $1"

	env_use "$1"
	info "Now using knife environment: $1"
}

