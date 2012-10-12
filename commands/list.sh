#! /usr/bin/env bash

require 'lib/console.sh'
require 'lib/help.sh' 
require 'lib/env.sh' 

list_usage() {
	echo "kcm list"
}

list_help() {
	bold "LIST HELP"
	echo

	printf '\t'; list_usage
	echo

	bold "DESCRIPTION"
	printf "%s\n" "
	List all the currently configured environments.  
"

	bold "ARGUMENTS"
	printf "%s\n" "
	- None 
"
}

list() {
	if help? $@
	then
		list_help
		exit $? 
	fi

	info "** Current Environments **"
	echo 

	local list=($(env_list))
	local current=$(env_current)

	for dir in "${list[@]}"
	do
		if [[ "$dir" == "$current" ]]
		then
			info "$current *"
		else
			echo "$dir"
		fi
	done
}

