#!/bin/bash

rows=32
cols=$(( 256 / $rows))

for ((i1=0; i1 < $rows; i1++)); do
	for ((i2=0; i2 < $cols; i2++)); do
		a=$(($i2 * $rows + $i1))
		printf "\x1b[38;5;${a}m%-10s" "color${a}";
	done
	echo
done
