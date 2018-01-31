# 0xAF: my personal (user) bashrc

if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

function exists() { type -P $1 >/dev/null 2>&1; }

# colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dircolors/dircolors.256dark ]]; then
	#eval `dircolors -b ~/.dircolors/dircolors.256dark`
	eval `dircolors -b ~/.dircolors/LS_COLORS`
else
	eval `dircolors -b`
fi

if [ -n $DISPLAY ]; then
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}    | \007"'
fi

# Change the window title of X terminals 
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

# uncomment the following to activate bash-completion:
#[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

#export CVSROOT=:pserver:af@af.mis.bg:/root

if exists keychain; then
	keychain --inherit any -Q ~/.ssh/id_rsa ~/.ssh/old_id_dsa ~/.ssh/id_dsa.octagon ~/.ssh/github_rsa ~/.ssh/bitbucket_rsa ~/.ssh/git.0xaf.org_rsa A8B855BD DA3BB96F
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
alias winegame32="DRI_PRIME=1 thread_submit=true WINEPREFIX=~/.winegame32 WINEARCH=win32 wine"
alias winegame64='DRI_PRIME=1 thread_submit=true WINEPREFIX=~/.winegame \wine64'
#alias steam='DBUS_FATAL_WARNINGS=0 DRI_PRIME=1 \steam'
#alias steam32='DBUS_FATAL_WARNINGS=0 DRI_PRIME=1 linux32 \steam'
alias playonlinux='DRI_PRIME=1 thread_submit=true \playonlinux'
alias erp='GTK2_RC_FILES= openerp-client'
alias freemind='XMODIFIERS= \freemind'
alias sqldeveloper='XMODIFIERS= \sqldeveloper'
alias youtube2mp3="youtube-dl -x --audio-format mp3 -c -o '%(title)s - %(id)s.mp3'"
#alias ssh='ssh -e\|'
alias emacs=e
alias gmt=/storage/gps/software/garmin/gmaptool_linux/gmt
alias modbus_scanner='wine "/home/af/.wine/drive_c/Program Files/Chipkin Automation Systems/CAS Modbus Scanner/CAS Modbus Scanner.exe"'
alias citadel=/usr/local/citadel/citadel
alias minecraft='java -jar ~/.minecraft/launcher.jar'
alias swtor="WINEARCH=win32 WINEPREFIX=/storage/games/swtor wine '/storage/games/swtor/drive_c/Program Files/Electronic Arts/BioWare/Star Wars - The Old Republic/swtor_fix.exe' & WINEARCH=win32 WINEPREFIX=/storage/games/swtor wine '/storage/games/swtor/drive_c/Program Files/Electronic Arts/BioWare/Star Wars - The Old Republic/launcher.exe'"
alias moveslink='cd ~/.wine.moveslink/drive_c/Moveslink2_1_4_5_227; WINEPREFIX=~/.wine.moveslink WINEARCH=win32 wine Moveslink2.exe'
alias gameconqueror='su -c "cd /usr/local/share/gameconqueror;./GameConqueror.py"'
alias steam='DBUS_FATAL_WARNINGS=0 LD_PRELOAD="/usr/lib64/gcc/x86_64-pc-linux-gnu/5.4.0/32/libstdc++.so.6" LIBGL_DEBUG=verbose DRI_PRIME=1 \steam'
alias ati='LIBGL_DEBUG=verbose DRI_PRIME=1'

alias ls="$(type -P ls) --color=auto --group-directories-first -p"
alias grep="$(type -P grep) --color=auto"


#make-debug print-SOURCE_FILES
alias make-debug='make --eval="print-%: ; @echo $*=$($*)"'

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
export PATH="/home/af/perl5/bin:/home/af/go/bin:$PATH";


#source ~/perl5/perlbrew/etc/bashrc
#perlbrew off


export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export ANDROID_HOME=/home/af/devel/android/sdk
export PATH="$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/:$PATH";


# gopass
if exists gopass; then
	source <(gopass completion bash)
fi

#weather -l "Varna, Bulgaria" -u ca



unset -f exists
#source ~/perl5/perlbrew/etc/bashrc

export PATH=$PATH:/storage/hacks/lenovo_tab3_730x/bin


