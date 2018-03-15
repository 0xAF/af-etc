default:
	@echo "usage:"
	@echo "  make system - install system stuff with sudo"
	@echo "  make user   - install user specific stuff"

#sed -i.af-etc "s/\($TARGET_KEY *= *\).*/\1$REPLACEMENT_VALUE/" $CONFIG_FILE

check-root:
	@if [ `id -u` != 0 ]; then echo "[-] You need to be root to run this target."; exit 1; fi

system: check-root su-nopass system-files vim

user: user-files vim

user-files:
	@echo "[+] installing user files"
	@./install.sh -u

system-files:
	@echo "[+] installing system files"
	@./install.sh

vim:
	@echo "[+] setup vim"
	@mkdir -p ~/.vim/bundle
	@cd ~/.vim/bundle && rm -rf vim-airline && git clone https://github.com/vim-airline/vim-airline
	@cd ~/.vim/bundle && rm -rf vim-airline-themes && git clone https://github.com/vim-airline/vim-airline-themes
	@cd ~/.vim/bundle && rm -rf vim-indent-guides && git clone https://github.com/nathanaelkane/vim-indent-guides
	@cd ~/.vim/bundle && rm -rf vim-tmux && git clone https://github.com/tmux-plugins/vim-tmux

tmux:
	@echo "[+] setup tmux"
	@mkdir -p ~/.tmux/plugins
	@cd ~/.tmux/plugins && rm -rf tpm && git clone https://github.com/tmux-plugins/tpm

su-nopass:
	@echo "[+] 'su' without password if you are in 'sudo' group"
	@cp /etc/pam.d/su /etc/pam.d/su.af-etc || true
	@echo 'auth sufficient pam_wheel.so trust group=sudo' > /etc/pam.d/su || true
	@cat /etc/pam.d/su.af-etc >> /etc/pam.d/su || true

