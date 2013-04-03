# 0xAF: my personal (user) bashrc

if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

function exists() { type -P $1 >/dev/null 2>&1; }

# colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]]; then
	eval `dircolors -b ~/.dir_colors`
else
	eval `dircolors -b /etc/DIR_COLORS`
fi

if [ -n $DISPLAY ]; then
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}    | \007"'
fi

# Change the window title of X terminals 
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# uncomment the following to activate bash-completion:
#[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

#export CVSROOT=:pserver:af@af.mis.bg:/root

if exists keychain; then
	keychain --inherit any -Q ~/.ssh/id_dsa ~/.ssh/id_dsa.octagon ~/.ssh/github_rsa ~/.ssh/bitbucket_rsa A8B855BD
	. ~/.keychain/${HOSTNAME}-sh
	. ~/.keychain/${HOSTNAME}-sh-gpg
fi

exists fortune && fortune -a

# aliases
alias e='SESSION_MANAGER= gvim -geometry 130x50 --remote-silent -rv'
alias ssho='ssh -i ~/.ssh/id_dsa.octagon root@192.168.10.1'
alias sl='export MALLOC_CHECK_=0;./secondlife'
alias wineold='WINEPREFIX=~/.wine.old wine'
alias ie7='WINEPREFIX=~/.wine.ie7 wine "C:\Program Files\Internet Explorer\iexplore"'
alias ie8='WINEARCH=win32 WINEPREFIX=~/.wine.ie8 wine "C:\Program Files\Internet Explorer\iexplore"'
alias ie9='WINEPREFIX=~/.wine.ie9 wine "C:\Program Files\Internet Explorer\iexplore"'
alias cs5='WINEPREFIX=~/.wine.cs5 wine "/home/af/.wine.cs5/drive_c/Program Files/Adobe/Adobe Photoshop CS5/Photoshop.exe"'
alias pmp='WINEPREFIX=~/.wine.cs5 wine "/home/af/.wine.cs5/drive_c/Program Files/PhotomatixPro4/PhotomatixPro.exe"'
alias wine64="WINEPREFIX=~/.wine64 wine64"
alias winegame32="WINEPREFIX=~/.winegame32 WINEARCH=win32 wine"
alias winegame64='WINEPREFIX=~/.winegame \wine64'
alias erp='GTK2_RC_FILES= openerp-client'
alias freemind='XMODIFIERS= \freemind'
alias sqldeveloper='XMODIFIERS= \sqldeveloper'
alias youtube2mp3="youtube-dl -x --audio-format mp3 -c --restrict-filenames -o '%(title)s.%(ext)s'"
#alias ssh='ssh -e\|'
alias emacs=e

ida() {
	if [[ -z $1 ]]; then
		WINEPREFIX=/home/af/devel/ida/.wine wine /home/af/devel/ida/ida_v61/idag.exe
	else
		WINEPREFIX=/home/af/devel/ida/.wine wine $*
	fi
}

#export PATH=$PATH:~/local/bin:~/local/sbin:/sbin:/usr/sbin:/home/af/arm-toolchain462/bin/
#export PATH=$PATH:~/local/bin:~/local/sbin:/sbin:/usr/sbin:/home/af/devel/400d/gentoo32/arm-toolchain462/bin
#export PATH=$PATH:~/local/bin:~/local/sbin:/sbin:/usr/sbin:/home/af/arm/arm-toolchain462/bin
export PATH=$PATH:~/.local/bin:~/.local/sbin:/sbin:/usr/sbin

export PERL_LOCAL_LIB_ROOT="/home/af/perl5";
export PERL_MB_OPT="--install_base /home/af/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/af/perl5";
export PERL5LIB="/home/af/perl5/lib/perl5/x86_64-linux-thread-multi:/home/af/perl5/lib/perl5";
export PATH="/home/af/perl5/bin:$PATH";


unset -f exists
