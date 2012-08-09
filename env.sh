if [[ -z $kcm_home ]]
then
	export kcm_home=$HOME/.kcm
fi

PATH=$PATH:$kcm_home/bin
