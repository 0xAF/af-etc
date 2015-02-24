# 0xAF: this is my system-wide bashrc

# non-interactive shell checks
[ -z "$BASH_VERSION" -o -z "$PS1" -o -z "$BASH" ] && return # debian scripts fail to execute [[ ... ]] checks, so leave here
if [[ $- != *i* ]] ; then return; fi # shell is non-interactive... leave here


# check for program existence (only if it's a file)
function exists() { type -P $1 >/dev/null 2>&1; }

function set_ps1() { #{{{

	# Colors {{{

	# Reset
	local Color_Off='\[\e[0m\]'       # Text Reset

	# Regular Colors
	local Black='\[\e[0;30m\]'        # Black
	local Red='\[\e[0;31m\]'          # Red
	local Green='\[\e[0;32m\]'        # Green
	local Yellow='\[\e[0;33m\]'       # Yellow
	local Blue='\[\e[0;34m\]'         # Blue
	local Purple='\[\e[0;35m\]'       # Purple
	local Cyan='\[\e[0;36m\]'         # Cyan
	local White='\[\e[0;37m\]'        # White

	# Bold
	local BBlack='\[\e[1;30m\]'       # Black
	local BRed='\[\e[1;31m\]'         # Red
	local BGreen='\[\e[1;32m\]'       # Green
	local BYellow='\[\e[1;33m\]'      # Yellow
	local BBlue='\[\e[1;34m\]'        # Blue
	local BPurple='\[\e[1;35m\]'      # Purple
	local BCyan='\[\e[1;36m\]'        # Cyan
	local BWhite='\[\e[1;37m\]'       # White

	# Underline
	local UBlack='\[\e[4;30m\]'       # Black
	local URed='\[\e[4;31m\]'         # Red
	local UGreen='\[\e[4;32m\]'       # Green
	local UYellow='\[\e[4;33m\]'      # Yellow
	local UBlue='\[\e[4;34m\]'        # Blue
	local UPurple='\[\e[4;35m\]'      # Purple
	local UCyan='\[\e[4;36m\]'        # Cyan
	local UWhite='\[\e[4;37m\]'       # White

	# Background
	local On_Black='\[\e[40m\]'       # Black
	local On_Red='\[\e[41m\]'         # Red
	local On_Green='\[\e[42m\]'       # Green
	local On_Yellow='\[\e[43m\]'      # Yellow
	local On_Blue='\[\e[44m\]'        # Blue
	local On_Purple='\[\e[45m\]'      # Purple
	local On_Cyan='\[\e[46m\]'        # Cyan
	local On_White='\[\e[47m\]'       # White

	# High Intensity
	local IBlack='\[\e[0;90m\]'       # Black
	local IRed='\[\e[0;91m\]'         # Red
	local IGreen='\[\e[0;92m\]'       # Green
	local IYellow='\[\e[0;93m\]'      # Yellow
	local IBlue='\[\e[0;94m\]'        # Blue
	local IPurple='\[\e[0;95m\]'      # Purple
	local ICyan='\[\e[0;96m\]'        # Cyan
	local IWhite='\[\e[0;97m\]'       # White

	# Bold High Intensity
	local BIBlack='\[\e[1;90m\]'      # Black
	local BIRed='\[\e[1;91m\]'        # Red
	local BIGreen='\[\e[1;92m\]'      # Green
	local BIYellow='\[\e[1;93m\]'     # Yellow
	local BIBlue='\[\e[1;94m\]'       # Blue
	local BIPurple='\[\e[1;95m\]'     # Purple
	local BICyan='\[\e[1;96m\]'       # Cyan
	local BIWhite='\[\e[1;97m\]'      # White

	# High Intensity backgrounds
	local On_IBlack='\[\e[0;100m\]'   # Black
	local On_IRed='\[\e[0;101m\]'     # Red
	local On_IGreen='\[\e[0;102m\]'   # Green
	local On_IYellow='\[\e[0;103m\]'  # Yellow
	local On_IBlue='\[\e[0;104m\]'    # Blue
	local On_IPurple='\[\e[0;105m\]'  # Purple
	local On_ICyan='\[\e[0;106m\]'    # Cyan
	local On_IWhite='\[\e[0;107m\]'   # White

	#}}}
	local DefCol="${IBlack}"

	# i use Terminus font for linux-console/xterms and these symbols looks good on it
	# you may need to change them if you're using another font
	# use these pages to find and convert unicode chars
	# http://unicode-table.com/en/#23B7
	# http://0xcc.net/jsescape/

	#local _cmd_ok="\[\e[1;32m\]\342\216\267 "
	#local _cmd_not_ok="\[\e[1;31m\]\342\212\235"
	#local _cmd_ok="${BGreen}\342\223\245 ${DefCol}"
	#local _cmd_not_ok="${BRed}\342\223\247 ${DefCol}"
	local _cmd_ok="${BWhite}*${DefCol}"
	local _cmd_not_ok="${BRed}x${DefCol}"
	local _finish_line="\342\225\274"
	#local _line1_1="\342\224\214"
	local _line1_1="\342\225\276"
	local _line="\342\224\200"
	#local _col="\342\224\202"
	#local _left_wall="\342\224\244"
	#local _right_wall="\342\224\234"
	local _left_wall="["
	local _right_wall="]"
	local _col="]"
	
	local _username="${BGreen}\u@\h${DefCol}";
	local _path="${BBlue}\w${DefCol}"
	local _prompt="${BYellow}\\\$${DefCol}"
	[[ ${EUID} == 0 ]] && _username="${BRed}\h${DefCol}" && _path="${BBlue}\W${DefCol}" && _prompt="${BRed}\\\$${DefCol}"

	PS1="${DefCol}${_line1_1}${_left_wall}\$( [[ \$? == 0 ]] && echo \"$_cmd_ok\" || echo \"$_cmd_not_ok\" )${_right_wall}${_line}${_left_wall}${_username}${_right_wall}${_line}${_left_wall}${_path}${_right_wall}${_line}${_left_wall}${_prompt}${_right_wall}${_finish_line} ${BWhite}"

	# this is to clear the bold white after hitting enter
	trap "echo -ne \\\e[0m" DEBUG

	# -----------------------------------------------------------------
} #}}}

# if you do not like the unicode prompt, uncomment the following lines and comment-out the set_ps1

#if [[ ${EUID} == 0 ]] ; then
#	PS1='\[\e[01;31m\]\h\[\e[01;34m\] \W \[\e[1;31m\]\$ \[\e[0m\e[1m\]'
#else
#	PS1='\[\e[01;32m\]\u@\h\[\e[01;34m\] \w \[\e[1;33m\]\$ \[\e[0m\e[1m\]'
#fi
#trap "echo -ne \\\e[0m" DEBUG
set_ps1

# save history at every new line
PROMPT_COMMAND='history -a'

# History: don't store duplicates
export HISTCONTROL=erasedups  
# History: 10,000 entries
export HISTSIZE=10000

# When changing directory small typos can be ignored by Bash
# cd /vr/lgo/apaache
# will result in: /var/log/apache
#shopt -s cdspell

export PATH=$PATH:/usr/local/bin:/usr/local/sbin

exists dircolors && eval $(dircolors -b)

# add colors to man pages {{{
export GROFF_NO_SGR=1 # this is needed to have colorful man
# Less Colors for Man Pages
man_color_set=0;
case "$man_color_set" in
	1) # color set 1
		export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
		export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
		export LESS_TERMCAP_me=$'\E[0m'           # end mode
		export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
		export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
		export LESS_TERMCAP_ue=$'\E[0m'           # end underline
		export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
		;;
	*) # default (from debian)
		export LESS_TERMCAP_mb=$'\E[01;31m'
		export LESS_TERMCAP_md=$'\E[01;31m'
		export LESS_TERMCAP_me=$'\E[0m'
		export LESS_TERMCAP_se=$'\E[0m'
		export LESS_TERMCAP_so=$'\E[01;44;33m'
		export LESS_TERMCAP_ue=$'\E[0m'
		export LESS_TERMCAP_us=$'\E[01;32m'
		;;
esac
#}}}

export LESS="$LESS -i -r -M"
export LESSCOLOR=yes
exists lesspipe.sh	&& export LESSOPEN="|lesspipe.sh %s"
exists lesspipe		&& export LESSOPEN="|lesspipe %s"
exists pygmentize	&& export LESSCOLORIZER=pygmentize
exists vim		&& export EDITOR=$(type -P vim)
exists less		&& export PAGER=$(type -P less)
#[ -x /bin/vimpager ]	&& export PAGER=/bin/vimpager && alias less=$PAGER

# vim man pager will ignore these less colors, but it uses it's own
#export MANPAGER=vimmanpager

# grep color
export GREP_COLOR="1;33"

export MINICOM="-c on"

# let me see the mountpoints in clear way
exists mount && exists column && mount() { if [[ -z $1 ]]; then /bin/mount | column -t ; else /bin/mount $*; fi }

# aliases {{{
# we add sbin to path temporarily
PATH=$PATH:/sbin:/usr/sbin
# we use "type -P" here to get the full path to the binary
exists aptitude 	&& alias a=$(type -P aptitude)
exists pacman		&& alias p=$(type -P pacman)
exists pacman-color	&& alias p=$(type -P pacman-color)
exists yaourt		&& alias y=$(type -P yaourt)
exists mtr		&& alias mtr="$(type -P mtr) --curses"
exists mplayer		&& alias mplayer='LANG=bg_BG.UTF-8 LC_ALL=bg_BG.UTF-8 LANGUAGE=bg_BG.UTF-8 mplayer -subcp cp1251'
exists equo		&& alias eq=$(type -P equo)
exists wget		&& alias wget="$(type -P wget) --trust-server-names --content-disposition"
exists curl		&& alias pastesprunge="$(type -P curl) -F \"sprunge=<-\" http://sprunge.us"
exists xargs		&& alias map="$(type -P xargs) -n1"
exists vim 		&& alias vi=$(type -P vim)
alias path='echo -e ${PATH//:/\\n}'
unalias ls 2>/dev/null
alias ls="$(type -P ls) --color=auto --group-directories-first -p"
alias grep="$(type -P grep) --color=auto"
alias rot13='perl -pe "y/A-Za-z/N-ZA-Mn-za-m/;"'
alias ff='find . -iname'
alias telnetssl='openssl s_client -crlf -connect'
alias psc='ps xawf -eo pid,user,cgroup,args'
#}}}

# For vim in Arch: http://bbs.archlinux.org/viewtopic.php?id=36221
# So that it actually uses ~/.vimrc
export EDITOR=vim
export VISUAL=vim

# yes, I intentionally force the TERM to linux, I like it this way, even in my X terminals
export TERM=linux


# root stuff
#if [[ ${EUID} == 0 ]] ; then
#	# rc scripts managing
#	rc() { /etc/rc.d/$*; }
#	complete -o filenames -W "$(cd /etc/rc.d/ && echo *)" rc
#
#	rc-start() { for arg in $*; do rc $arg start; done }
#	rc-restart() { for arg in $*; do rc $arg restart; done }
#	rc-stop() { for arg in $*; do rc $arg stop; done }
#	rc-status() { for arg in $*; do rc $arg status; done }
#fi

log() {
	# sudo if not root
	if [[ ${EUID} != 0 ]] ; then
		echo got root \?
		return 1
	fi

	wanted=$1

	# what to use for tail
	tail="tail -F -n 150"
	#tail="grc -c conf.metalog tail -F -n 150"
	type -P grc >/dev/null 2>&1 && tail="grc -c conf.log tail -F -n 150"

	#[[ -z $wanted ]] && wanted="everything"
	[[ -z $wanted ]] && wanted="messages"

	if [[ ! -f $wanted ]]; then
		#locations=/var/log/{$wanted,$wanted.log,$wanted/{$wanted,current}}
		locations="				\
			/var/log/$wanted		\
			/var/log/$wanted.log		\
			/var/log/$wanted/$wanted	\
			/var/log/$wanted/current	\
		"
		for l in $locations; do
			[[ -f $l ]] && log $l && return 0
		done

		echo "cannot find '$wanted' in any of the following locations:"
		for l in $locations; do
			echo $l
		done
		return
	fi

	echo "$wanted"
	echo
	$tail $wanted
}


unset -f exists

