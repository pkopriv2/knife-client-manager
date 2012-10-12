#! /usr/bin/env bash

export kcm_home="${kcm_home:-${HOME}/.kcm}"
export kcm_env_home="$kcm_home/env"
export chef_home="${chef_home:-${HOME}/.chef}"

require 'lib/fail.sh' 

env_list() {
	local list=($(builtin cd "$kcm_env_home" ; find . -maxdepth 1 -mindepth 1 -type d -print | sed 's|^\.\/||' | sort ))

	for dir in "${list[@]}"
	do
		echo "$dir"
	done
}

env_current() {
	if [[ ! -L $chef_home ]]
	then
		return 0
	fi

	echo "$(readlink "$chef_home" | xargs basename)"
}

env_unuse() {
	if [[ -L $chef_home ]]
	then
		rm $chef_home &> /dev/null
	fi
}

env_delete() {
	if env_exists "$1"
	then
		rm -fr "$kcm_env_home/$1"
		return $?
	fi

	return 1
}

env_use() {
	if (( $# != 1 ))
	then
		fail "usage: env_use <environment>"
	fi

	ln -s "$kcm_env_home/$1" "$chef_home"
}

env_exists() {
	if [[ -z "$1" ]] 
	then
		return 1 # will never exist
	fi

	[[ -d  "$kcm_env_home/$1" ]]; return $?
}

env_migrate() {
	if [[ ! -d $chef_home ]]
	then
		return 0
	fi

	local files=($(builtin cd "$chef_home" ; find . -maxdepth 1 -mindepth 1 -print | sed "s/^\.\///" )) 
	for file in "${files[@]}"
	do
		$(builtin cd "$chef_home" ; mv "$file" "$kcm_env_home/system/$file")
	done

	rm -rf $chef_home
}
