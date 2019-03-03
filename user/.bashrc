# 0xAF: my personal (user) bashrc

if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

function exists() { type -P $1 >/dev/null 2>&1; }

if [[ -f ~/.dircolors/LS_COLORS ]]; then
	eval `dircolors -b ~/.dircolors/LS_COLORS`
else
	eval `dircolors -b`
fi

#if [ -n $DISPLAY ]; then
	#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}    | \007"'
	#export COLORTERM=truecolor
#fi

case $TERM in
	xterm*|rxvt*|Eterm)
		#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen*)
		#PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

if exists keychain; then
	# ~/.ssh/old_id_dsa ~/.ssh/id_dsa.octagon
	keychain --inherit any -Q ~/.ssh/id_rsa ~/.ssh/github_rsa ~/.ssh/bitbucket_rsa ~/.ssh/git.0xaf.org_rsa A8B855BD DA3BB96F
	. ~/.keychain/${HOSTNAME}-sh
	. ~/.keychain/${HOSTNAME}-sh-gpg
fi

exists fortune && fortune -ac

# aliases
#alias ssh='ssh -e\|'
alias ls="$(type -P ls) --color=auto --group-directories-first -p"
alias grep="$(type -P grep) --color=auto"


#make-debug print-SOURCE_FILES
alias make-debug='make --eval="print-%: ; @echo $*=$($*)"'

export PATH=$PATH:~/.local/bin:~/.local/sbin:/sbin:/usr/sbin

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# gopass
if exists gopass; then
	source <(gopass completion bash)
fi

# sensitive data
if [[ -f ~/.bashrc.local ]]; then
	source ~/.bashrc.local
fi

unset -f exists

