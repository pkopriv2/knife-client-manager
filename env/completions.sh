#! /usr/bin/env bash

export kcm_home="${kcm_home:-${HOME}/.kcm}"
export kcm_env_home=${kcm_env_home:-$kcm_home/env}

_kcm_complete() {
	_kcm_env_list() {
		(
			builtin cd "$kcm_env_home" ; find . -maxdepth 1 -mindepth 1 -type d -print | sed 's|^\.\/||' | sort 
		)
	}

	local cur=${COMP_WORDS[COMP_CWORD]}
	local cmd=""
	local index=1
	while (( index < COMP_CWORD )) 
	do
		cmd+=":${COMP_WORDS[index]}"
		(( index++ ))
	done

	COMPREPLY=()   

	case "$cmd" in
		"")
			local commands=( \
				configure \
				create    \
				current   \
				delete    \
				info      \
				list      \
				unuse     \
				use       \
			)

			COMPREPLY=( $( compgen -W '${commands[@]}' -- $cur ) )
			;;
		:use)
			local environments=( $(_kcm_env_list) )
			COMPREPLY=( $( compgen -W '${environments[@]}' -- $cur ) )
			;;
		:delete)
			local environments=( $(_kcm_env_list) )
			COMPREPLY=( $( compgen -W '${environments[@]}' -- $cur ) )
			;;
	esac

	unset -f _kcm_env_list
	return 0
}

if [[ ! -z $BASH ]]
then
	complete -F _kcm_complete kcm
fi
