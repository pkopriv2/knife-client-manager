#! /usr/bin/env bash

export kcm_home=${kcm_home:-${HOME}/.kcm}
export kcm_env_home=${kcm_env_home:-$kcm_home/env}
export chef_home="${chef_home:-${HOME}/.chef}"

require 'lib/help.sh'
require 'lib/console.sh'

configure_usage() {
	echo "kcm configure <address>"
}

configure_help() {
	bold "CONFIGURE HELP"
	echo

	printf '\t'; configure_usage
	echo

	bold "DESCRIPTION"

	printf "%s\n" "
	Configure/Reconfigure a knife client to point to the given address.  
	This requires that the validation.pem file and the webui.pem file
	be located under ~/.chef.  
"

	bold "ARGUMENTS"

	printf "%s\n" "
	- address The address of the chef server.  This should be the complete 
	          address including protocol and port. (e.g. http://localhost:4000)
"
}

configure() {
	if help? "$@"
	then
		configure_help
		exit $?
	fi

	if [[ -z $1 ]]
	then
		error "Must provide the address of the chef-server. (e.g. http://chef-server:4000)" 
		exit 1
	fi

	if [[ ! -L $chef_home ]]
	then
		error "No active environment.  Please use *kcm use [environment] first."
		exit 1
	fi

	local file_webui=$( builtin cd $chef_home;  echo "$(pwd)/webui.pem")
	if [[ ! -f $file_webui ]]
	then
		error "Unable to locate webui pem file: $file_webui" 
		exit 1
	fi

	local file_validation=$( builtin cd $chef_home;  echo "$(pwd)/validation.pem")
	if [[ ! -f $file_validation ]]
	then
		error "Unable to locate validation pem file: $file_validation" 
		exit 1
	fi

	local file_knife_rb=$chef_home/knife.rb
	if [[ -f $file_knife_rb ]]
	then
		read -p "Deleting current knife.rb.  Are you sure? (y|n): " answer

		if [[ "$answer" != "y" ]] 
		then
			echo "Aborting."
			exit 0
		fi

		rm -f $file_knife_rb 
	fi

	if ! command -v knife &> /dev/null
	then
		error "Knife command is not available.  Make sure it is on your path."
		exit 1
	fi
	
	if ! printf "\n$1\n\n\n$file_webui\n\n$file_validation\n\n" | knife configure -i 1>/dev/null
	then
		error "Error configuring knife.  Try manually configuring it."
		exit 1
	fi
}

