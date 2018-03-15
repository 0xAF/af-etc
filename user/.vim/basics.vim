" general setup
"set sta		" smarttab
"---------

" http://vimcasts.org/episodes/tabs-and-spaces/
" 4 spaces expanded and backspace deletes 4 spaces too
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set showmatch           " jump emacs style to matching bracket
set incsearch           " highlight match while typing search pattern
" set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set noerrorbells
"set visualbell
set novisualbell

"set cursorline " Highlight the screen line of the cursor
"set cursorcolumn " Highlight the screen column of the cursor

" allow vim to read lines like '# vim: ts=4 sw=4'
set modeline
set modelines=4

set nobackup
set nowritebackup

set ttyfast " Indicates a fast terminal connection.


set list " show some invisible chars
" set listchars=nbsp:•,tab:▸\ ,eol:¬,trail:·,extends:↷,precedes:↶
"set listchars=nbsp:•,tab:▸\ ,trail:·,extends:↷,precedes:↶
set listchars=nbsp:•,tab:\ \ ,trail:·,extends:↷,precedes:↶


" set line wrapping at word
set lbr

" some plugins may fail with this, see the autocmd's for better way
"set autochdir

" write swap files to this dir
set dir=~/.vim/tmp

autocmd BufRead *.txt set tw=78
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif


set foldenable
set foldmethod=marker
set fcs=vert:\|,fold:\ 
set foldcolumn=2

set autowrite
if !has('nvim')
	set textauto
endif

" More useful command-line completion
set wildmenu

"Auto-completion menu
set wildmode=list:longest,full
"set wildmode=longest,list
set wildignore=*.bak,~,*.o,*.info,*.swp

" Ignoring case is a fun trick, but only with smartcase
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" Spaces are better than a tab character
"set expandtab
"set smarttab

" center the screen when searching next/prev
map N Nzz
map n nzz

filetype plugin on
filetype indent on

set undodir=$HOME/.vim/undos
set undofile        " new feature of undo files

"ab (C) Copyright (c) 2004 Stanislav Lechev [AngelFire]. All rights reserved.
set tags=tags

"set makeprg=/usr/local/bin/vimmake\ %<\ %

" do not jump to first nonblank char at line
set nosol

" When I close a tab, remove the buffer
"set nohidden

" hidden - don't unload a buffer when no longer shown in a window
" this allows us to switch buffers w/o saving
set hid

" mousefocus	the window with the mouse pointer becomes the current one
set nomousef


" Yep, and finally
syntax on
set hlsearch
set secure

" set status line to 2 lines
set ch=2

" to update system tags run:
" ctags -R -f ~/.vim/systags --c-kinds=+p /usr/include /usr/local/include
"set tags+=~/.vim/systags

setlocal spelllang=en_us


" do not clear the screen on exit (in TERM=xterm)
set t_ti= t_te=

