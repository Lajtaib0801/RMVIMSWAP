#!/bin/bash


PATHTOSWAPS=/home/$(whoami)/.cache/vim/swap
p=$(ls -la $PATHTOSWAPS | sed "1,3d" | wc -l 2>/dev/null)
n=0


if [ -d "$PATHTOSWAPS" ] && [ "$p" -gt 0 ]; then
    for file in $PATHTOSWAPS/*; do
		let n++
    done
	rm ${PATHTOSWAPS}/*
    echo "${n} swapfiles has been removed from '$PATHTOSWAPS'"
	exit
else
	if [ -d "$PATHTOSWAPS" ]; then
		echo "${PATHTOSWAPS} is empty!"
		exit
	else
		echo "'${PATHTOSWAPS}' does not exist! Do you want to create one? [y/N]"
		read create
		if [ -z "$create" ]; then
			create="N"
		fi
		if [ "${create^}" = "Y" ]; then
			mkdir -p $PATHTOSWAPS
			if [ ! -f /home/$(whoami)/.vimrc ]; then
				echo "You do not have .vimrc in your home! Do you want to create one? [y/N]"
				read createvimrc
				if [ -z "$createvimrc" ]; then
					createvimrc="N"
				fi
				if [ "${createvimrc^}" = "Y" ]; then
					touch /home/$(whoami)/.vimrc
					echo "set directory=$HOME/.cache/vim/swap//" >> /home/$(whoami)/.vimrc
				elif [ "${createvimrc^}" = "N" ]; then
					exit
				fi
			fi
		elif [ "${create^}" = "N" ]; then
			exit
		else
			echo "Correct inputs: 'y or Y' =yes, 'n or N' =no!"
		fi
	fi
fi
	
