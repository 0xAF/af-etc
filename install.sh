#!/bin/bash
# 0xAF: this is install script for my /etc essential files, I use this on newly installed systems.

trap "unset -f exists; unset -f die" EXIT

function exists() { type -P $1 >/dev/null 2>&1; }
function die() { echo; echo $*; echo; exit 1; }

echo "0xAF: call this script with root to install system-wide stuff"
echo "0xAF: call this script with user to install user specific stuff"
echo "0xAF: call this script with '-f' option to force overwrite"
echo

exists dirname	|| die "cannot find 'dirname' utility..."
exists basename	|| die "cannot find 'basename' utility..."
exists find	|| die "cannot find 'find' utility..."
exists grep	|| die "cannot find 'grep' utility..."
exists install	|| die "cannot find 'install' utility..."
exists md5sum	|| die "cannot find 'md5sum' utility..."
exists cut	|| die "cannot find 'cut' utility..."

cd "$(dirname $0)"

[[ "$1" = "-f" ]] && overwrite=" (force-overwrite)"

echo -n "installing "
(( $EUID )) && echo -n "user specific" || echo -n "system-wide"
echo " stuff${overwrite}..."
echo

echo "hit [enter] to run / ctrl-c to exit"
read

DEST_DIR=""; # system-wide
(( $EUID )) && DEST_DIR="$(cd;pwd)"


function install() {
	local src=$1
	local dst=$2
	local md5src=""
	local md5dst=""
	local cp=$overwrite

	md5src=$(md5sum $src | cut -d' ' -f1)
	[[ -f $dst ]] && md5dst=$(md5sum $dst | cut -d' ' -f1)

	if [[ "$md5src" = "$md5dst" ]]; then
		echo -e "[SKIP]\t$dst"
		return
	fi

	if [[ -f $dst ]]; then # file exists
		echo -en "[DIFF]\t$dst -> Overwrite ? Yes/[no] : "
		if [[ -z $cp ]]; then # no force
			read ans
			[[ "$ans" = "Yes" ]] && cp=1
		else # force
			echo "Yes"
		fi

	else
		# new file
		cp=1
	fi


	if [[ -n $cp ]]; then
		echo -e "[COPY]\t$dst"
		mkdir -p "$(dirname $dst)"
		cp -p $src $dst
		chown $usr:$grp $dst
	fi

}




# find the files
look="root"
usr="root"
grp="root"
(( $EUID )) && look="user" && usr=$(id -u) && grp=$(id -g)

files=( $( find $look -mindepth 1 -type f | grep -v "\.git\/" ) )

for (( x=$((${#files[@]} - 1)) ; x >= 0; x-- )); do
	[[ ! -f ${files[$x]} ]] && continue
	fd=$(dirname ${files[$x]})
	fn=$(basename ${files[$x]})
	fd=${fd/#\./};
	fd=${fd/$look/};
	fd=${fd/#\//};
	fd=${fd/%\//};

	[[ -n "$fd" ]] && fd="$fd/"

	install "$look/$fd$fn" "$DEST_DIR/$fd$fn"
done

#uniq_dirs=$( ( IFS=$'\n'; echo "${INSTD[*]}" ) | sort | uniq )


