#!/bin/bash


files=( $( find . -path "./user/*" -o -path "./root/*" ) )

for (( x=$((${#files[@]} - 1)) ; x >= 0; x-- )); do
	[[ ! -f ${files[$x]} ]] && continue
	fd=$(dirname ${files[$x]})
	fn=$(basename ${files[$x]})
	fd=${fd/#\./};
	fd=${fd/$look/};
	fd=${fd/#\//};
	fd=${fd/%\//};

	[[ -n "$fd" ]] && fd="$fd/"

	nf="./$fd$fn"
	of="$fd$fn"
	of=${of/#root\//\/}
	of=${of/#user\//~/}

	if [ -f "$of" ]; then
		DIFF=$(diff -u "$nf" "$of")
		if [[ $? -ne 0 ]]; then
			echo -------------------------------------------
			echo "$DIFF"
			echo "$of -> $nf"
			cp -iv "$of" "$nf"
		fi
	fi
done

