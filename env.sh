if [[ -z $kcm_home ]]
then
	export kcm_home=$HOME/.kcm
fi

PATH=$PATH:$kcm_home/bin

for script in $kcm_home/env/*.sh
do
	if [[ -f $script ]] 
	then
		source $script
	fi
done
