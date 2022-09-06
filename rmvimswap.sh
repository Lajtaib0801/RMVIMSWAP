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
		if [ "${create^}" = "Y" ]; then
			mkdir -p $PATHTOSWAPS
		elif [ "${create^}" = "N" ]; then
			exit
		else
			echo "Correct inputs: 'y or Y' =yes, 'n or N' =no!"
		fi
	fi
fi
