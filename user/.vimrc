" AngelFire's .vimrc file

" general setup {{{
"set sts=4		" softtabstop
"set sta		" smarttab
"set et			" expandtab
"---------
set ts=8		" tabstop
set sw=8		" shift (for indent)
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

" allow vim to read lines like '# vim: ts=4 sw=4'
set modeline

set nobackup
set nowritebackup

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

set foldenable
set foldmethod=marker

set autowrite
set textauto

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

" When I close a tab, remove the buffer
set nohidden

" Spaces are better than a tab character
"set expandtab
"set smarttab

" center the screen when searching next/prev
map N Nzz
map n nzz

if version >= 600
	filetype plugin on
	filetype indent on
endif

"ab (C) Copyright (c) 2004 Stanislav Lechev [AngelFire]. All rights reserved.
set tags=tags

"set makeprg=/usr/local/bin/vimmake\ %<\ %

" do not jump to first nonblank char at line
set nosol

set fcs=vert:\|,fold:\ 

" hidden - don't unload a buffer when no longer shown in a window
set hid

" mousefocus	the window with the mouse pointer becomes the current one
set nomousef

set foldcolumn=2

" Yep, and finally
syntax on
set secure

" set status line to 2 lines
set ch=2

" to update system tags run:
" ctags -R -f ~/.vim/systags --c-kinds=+p /usr/include /usr/local/include
"set tags+=~/.vim/systags

setlocal spelllang=en_us

" }}}
" autocmd's {{{
if has("autocmd")



" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78

au FileType html,xhtml,tt2html setlocal tabstop=2 shiftwidth=2 softtabstop=2 sidescroll=2
au FileType perl,js,jquery setlocal tabstop=4 shiftwidth=4 softtabstop=4 sidescroll=4 noet
"autocmd FileType perl set fp=perltidy\ -w\ -b\ -ole=unix\ -csc\ -ce\ -et=4
"autocmd FileType perl map <C-i> :%!perltidy -w -b -ole=unix -csc -ce -et=4<CR>
" autocmd FileType c,cpp map <C-i> :%!indent -kr -l78 -lc78 -bap -bbb -nbbo -br -brs -bs -cdb -cs -nbfda -ut -i8 -pcs -npsl -saf -sai -saw -ss -ts8 -nfca -npcs -nprs -ppi2 <CR>
" autocmd FileType c,cpp map <C-i> :%!indent<CR>

augroup cprog
	" Remove all cprog autocommands
	au!

	" When starting to edit a file:
	"   For C and C++ files set formatting of comments and set C-indenting on.
	"   For other files switch it off.
	"   Don't change the order, it's important that the line with * comes first.
	"   fo: ro - auto insert comment after enter/o command
	autocmd FileType *        set formatoptions=tcql nocindent comments&
	autocmd FileType c,cpp,h  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
	"vnoremap <F1> <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
augroup END

augroup gzip
	" Remove all gzip autocommands
	au!

	" Enable editing of gzipped files
	" set binary mode before reading the file
	autocmd BufReadPre,FileReadPre	*.gz,*.bz2 set bin
	autocmd BufReadPost,FileReadPost	*.gz call GZIP_read("gunzip")
	autocmd BufReadPost,FileReadPost	*.bz2 call GZIP_read("bunzip2")
	autocmd BufWritePost,FileWritePost	*.gz call GZIP_write("gzip")
	autocmd BufWritePost,FileWritePost	*.bz2 call GZIP_write("bzip2")
	autocmd FileAppendPre			*.gz call GZIP_appre("gunzip")
	autocmd FileAppendPre			*.bz2 call GZIP_appre("bunzip2")
	autocmd FileAppendPost		*.gz call GZIP_write("gzip")
	autocmd FileAppendPost		*.bz2 call GZIP_write("bzip2")

	fun! GZIP_read(cmd)
		let ch_save = &ch
		set ch=2
		execute "'[,']!" . a:cmd
		set nobin
		let &ch = ch_save
		execute ":doautocmd BufReadPost " . expand("%:r")
	endfun

	" After writing compressed file: Compress written file with "cmd"
	fun! GZIP_write(cmd)
		if rename(expand("<afile>"), expand("<afile>:r")) == 0
			execute "!" . a:cmd . " <afile>:r"
		endif
	endfun

	" Before appending to compressed file: Uncompress file with "cmd"
	fun! GZIP_appre(cmd)
		execute "!" . a:cmd . " <afile>"
		call rename(expand("<afile>:r"), expand("<afile>"))
	endfun

augroup END

autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * :cd %:p:h

" color in red everything after the 80'th char
"au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

endif " (autocmd)
" }}}
" general mappings {{{

" nice to have
command Q q
comman W w


" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

map <S-Tab>	:!(cd %:p:h;exuberant-ctags *.[ch] *.cpp *.cc)&<CR>

nnoremap  \  <C-^>

" in insert mode Ctrl-Space/Ctrl-BackSpace act as Ctrl-n/Ctrl-p
" for word compleation
"imap <C-Space> <C-n>
"imap <C-BS> <C-p>
imap <C-Space> <C-x><C-o>

"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
	\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
	\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"Bubble single lines (kicks butt)
"http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp

"Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]


" get current function name with _F
map _F ma[{b"xyy`a:echo @x<CR>

map <M-0> :b10<CR>
map <M-1> :b1<CR>
map <M-2> :b2<CR>
map <M-3> :b3<CR>
map <M-4> :b4<CR>
map <M-5> :b5<CR>
map <M-6> :b6<CR>
map <M-7> :b7<CR>
map <M-8> :b8<CR>
map <M-9> :b9<CR>
map <M-Left> :call AF_BP()<CR>
map <M-Right> :call AF_BN()<CR>
imap <M-Left> <ESC>:call AF_BP()<CR>a
imap <M-Right> <ESC>:call AF_BN()<CR>a
nmap <C-w> :bw<CR>

map <F2> :call AF_HelpBuffer()<CR>

" Now one can press enter in normal mode to insert an empty line. This spares me from alot of typing.
":nmap <enter> _i<enter><esc>
:nmap <enter> i<enter><esc>

" this maps space to ctrl-d in esc mode
:nmap <SPACE> <C-d>

" ctrl-q - :q!
:nmap <C-q> :q!<CR>

" Panic Button
noremap <F12> ggg?G``:set rl!<CR>

" when you are in visual mode and press down/up with shift
" it behaves like PgDown/PgUp (which is annoying)
vmap <S-Down> <Down>
vmap <S-Up> <Up>

map <C-d> ,c<SPACE>

" Toggle spelling
noremap <F11> :setlocal spell!<CR>

"Surround code with braces in visual
vmap <Leader>{} c{<ESC>pgv=

"}}}
" highlight extra white spaces {{{
"highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
"highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

"match ExtraWhitespace /\s\+\%#\@<!$/

"autocmd InsertLeave * redraw!

au InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /^\s* \s*\|\s\+$/

autocmd BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/
"}}}
" if it is gui {{{
if has("gui_running")
	colorscheme af

	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#292c2c ctermbg=3
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1c1f1f ctermbg=4

	"colorscheme blue
	"set gfn=Terminus\ 14
	set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 13
	"winsize 146 40
	"	let g:af_orig_titlestring = "[" . hostname() . "] %F%<%=%((%m%r)%) [F2 - Help]"
	let g:af_orig_titlestring = "%<%= %((%m%r)%) - [" . hostname() . "] - [F2 - Help]"
	auto BufEnter * let &titlestring = BuildBufferList(0) . g:af_orig_titlestring
	set titlelen=100
	set guioptions=agimrLtbp
	set lines=51 columns=160
	set linespace=1

	set statusline=
	set statusline +=%1*\ %n\ %*            "buffer number
	set statusline +=%5*%{&ff}%*            "file format
	set statusline +=%3*%y%*                "file type
	set statusline +=%4*\ %<%F%*            "full path
	set statusline +=%2*\ %3m%*                "modified flag
	set statusline +=%1*%=                  "align right
	set statusline +=%1*[%2*line:\ %1*%3l%2*/%3*%3L%2*/%5*%2p%%%1*]      "current/total/percent
	set statusline +=[%2*col:\ %1*%2c%2*/%1*%2v%1*]             "virtual column number
	set statusline +=[%2*char:\ %1*\%03.3b/0x%04B%1*]          "character under cursor
	set statusline +=%*

endif
"}}}
" some extra plugins {{{
" man pages
"source /usr/share/vim/vim72/ftplugin/man.vim
"imap <F1> <ESC>\K
"nmap <F1> \K
"}}}
" curly bracket {{{
" enable/disable curly bracket
let g:af_curly_bracket=0
if has("gui_running")
	auto BufEnter * let &titlestring = &titlestring." [CB: ".(g:af_curly_bracket ? "on" : "off")."]"
endif
au BufNewFile,BufRead *.c,*.cc,*.C,*.h,*.js let g:af_curly_bracket_comment = "//"
au BufNewFile,BufRead *.pl,*.pm let g:af_curly_bracket_comment = "#"
map <F10> :call AFCBSwitch()<CR>

function AFCB_ON()
	inoremap { {<ESC>m"o}<ESC>:call AFCurlyBracket()<CR>`"a
	imap ( ()<Left>
	inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
endfunction

function AFCB_OFF()
	if (hasmapto("{", "i"))
		iunmap {
" }
	endif
	if (hasmapto("(", "i"))
		iunmap (
	endif
	if (hasmapto(")", "i"))
		iunmap )
	endif
endfunction

function AFCBSwitch()
	let g:af_curly_bracket=!g:af_curly_bracket
	if has("gui_running")
		let &titlestring = substitute(&titlestring, '\[CB:\s*\(\w*\)\]', (g:af_curly_bracket ? '[CB: on]' : '[CB: off]'), 'i')
	else
		echo "Curly Bracket: " (g:af_curly_bracket ? "on" : "off")
	endif
	if g:af_curly_bracket
		call AFCB_ON()
	else
		call AFCB_OFF()
	endif
endfunction

function AFCurlyBracket()
	call AFCB_OFF()
	let l:my_linenum = line(".")
	let l:result1 =  searchpair('{', '', '}', 'bW')
	if (result1 > 0)
		let l:my_string = substitute(getline("."), '^\s*\(.*\)\s*{', '\1', "")
		let l:my_string2= substitute(l:my_string,"^\\s\\+\\|\\s\\+$","","g")
		sil exe ":" . l:my_linenum
		sil exe "normal a ".g:af_curly_bracket_comment ." ". l:my_string2
	endif
	call AFCB_ON()
endfunction

"au BufNewFile,BufRead *.c,*.cc,*.C,*.h,*.js call AFCB_ON()

"}}}
" Function from minibufexplorer {{{
function BuildBufferList(delBufNum)

	let l:NBuffers = bufnr('$')     " Get the number of the last buffer.
	let l:i = 0                     " Set the buffer index to zero.

	let l:fileNames = ''

	" Loop through every buffer less than the total number of buffers.
	while(l:i <= l:NBuffers)
		let l:i = l:i + 1

		" If we have a delBufNum and it is the current
		" buffer then ignore the current buffer. 
		" Otherwise, continue.
		if (a:delBufNum == -1 || l:i != a:delBufNum)
			" Make sure the buffer in question is listed.
			if(getbufvar(l:i, '&buflisted') == 1)
				" Get the name of the buffer.
				let l:BufName = bufname(l:i)
				" Check to see if the buffer is a blank or not. If the buffer does have
				" a name, process it.
				if(strlen(l:BufName))
					" Only show modifiable buffers (The idea is that we don't 
					" want to show Explorers)
					if (getbufvar(l:i, '&modifiable') == 1 && BufName != '-MiniBufExplorer-')

						" Get filename & Remove []'s & ()'s
						let l:shortBufName = fnamemodify(l:BufName, ":t")                  
						let l:shortBufName = substitute(l:shortBufName, '[][()]-<>', '', 'g') 

						" If the buffer is open in a window mark it
						if bufwinnr(l:i) != -1
							let l:fileNames = l:fileNames.'   -->['.l:i.':'.l:shortBufName.']<--   '
						else
							let l:fileNames = l:fileNames.'['.l:i.':'.l:shortBufName.']'
						endif

						" If the buffer is modified then mark it
						if(getbufvar(l:i, '&modified') == 1)
							let l:fileNames = l:fileNames . '+'
						endif

						" If tab wrap is turned on we need to add spaces
						let l:fileNames = l:fileNames.' '

					endif
				endif
			endif
		endif
	endwhile

	return l:fileNames
endfunction

" }}}
" af buffer functions {{{
function AF_BP()
	if ((bufloaded(1)) && (! buffer_name(1)))
		bw 1
	endif
	"	MBEbp
	bp
endfunction

function AF_BN()
	if ((bufloaded(1)) && (! buffer_name(1)))
		bw 1
	endif
	"	MBEbn
	bn
endfunction

function AF_HelpBuffer()
	let l:startBufNr = winbufnr(0)

	execute "enew"

	let l:viewBufNr = winbufnr(0)

	setlocal nomodifiable
	setlocal noswapfile
	setlocal buftype=nowrite
	setlocal bufhidden=delete

	let l:QUITCMD = "nnoremap <buffer> <silent> q :b " . l:startBufNr . "<cr>:bw " . l:viewBufNr . "<cr>"
	execute l:QUITCMD


	let s:txt =         "\"             AF Help Screen\n"
	let s:txt = s:txt . "\"            ================\n"
	let s:txt = s:txt . "\" q - quit this screen\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . " F2  - This Help\n"
	let s:txt = s:txt . " F10 - CB on/off\n"
	let s:txt = s:txt . " F11 - toggle spelling\n"
	let s:txt = s:txt . " F12 - Panic Button\n"
	let s:txt = s:txt . " _F  - Function Name\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . " Ctrl-Space / Ctrl-BS - act as C-n / C-p  - word compleation\n"
	let s:txt = s:txt . " M-[0-9] - Switch to buffer [1-10]\n"
	let s:txt = s:txt . " M-Left / M-Right - Switch buffers left/right\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . " guu - lowercase line\n"
	let s:txt = s:txt . " gUU - uppercase line\n"
	let s:txt = s:txt . " gf  - open file under cursor\n"
	let s:txt = s:txt . " C-A/C-X - Inc/Dec number under cursor\n"
	let s:txt = s:txt . " CTRL-R=5*5 - insert 25 into text\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . " '.  - jump to last modification line\n"
	let s:txt = s:txt . " `.  - jump to exact spot in last modification line\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . ",a  - enable syntax for ifdef DEBUG.* (helps to find debug stuff)\n"
	let s:txt = s:txt . ",x  - disable syntax for ifdef DEBUG.*\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . "    Foldings:\n"
	let s:txt = s:txt . "\n"
	let s:txt = s:txt . "zf#j creates a fold from the cursor down # lines.\n"
	let s:txt = s:txt . "zf/string creates a fold from the cursor to string .\n"
	let s:txt = s:txt . "zj moves the cursor to the next fold.\n"
	let s:txt = s:txt . "zk moves the cursor to the previous fold.\n"
	let s:txt = s:txt . "zo opens a fold at the cursor.\n"
	let s:txt = s:txt . "zO opens all folds at the cursor.\n"
	let s:txt = s:txt . "zm increases the foldlevel by one.\n"
	let s:txt = s:txt . "zM closes all open folds. <-- I still keep forgeting this ...\n"
	let s:txt = s:txt . "zr decreases the foldlevel by one.\n"
	let s:txt = s:txt . "zR decreases the foldlevel to zero -- all folds will be open.\n"
	let s:txt = s:txt . "zd deletes the fold at the cursor.\n"
	let s:txt = s:txt . "zE deletes all folds.\n"
	let s:txt = s:txt . "[z move to start of open fold.\n"
	let s:txt = s:txt . "]z move to end of open fold.\n"

	setlocal modifiable
	put! = s:txt
	setlocal nomodifiable

endfunction
" }}}
" highlight debug blocks {{{
syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip

let g:CommentDefines = ""

hi link MyCommentOut2 MyCommentOut
hi link MySkip MyCommentOut
hi link MyCommentOut Comment

map <silent> ,a :call AddCommentDefine()<CR>
map <silent> ,x :call ClearCommentDefine()<CR>

function! AddCommentDefine()
	let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
	syn clear MyCommentOut
	syn clear MyCommentOut2
	exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$" contains=MyCommentOut2'
	exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '" end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
endfunction

function! ClearCommentDefine()
	let g:ClearCommentDefine = ""
	syn clear MyCommentOut
	syn clear MyCommentOut2
endfunction
"}}}


" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
"if has("autocmd")
	"augroup myvimrchooks
		"au!
		"autocmd bufwritepost .vimrc source ~/.vimrc
	"augroup END
"endif

" write the viminfo file (don't know why it's written only when quiting vim)
au BufDelete * wv

" check for .vimrc.custom in the file's directory
au BufNewFile,BufRead * call CheckForCustomConfiguration()

function! CheckForCustomConfiguration()
	" Check for .vimrc.custom in the directory containing the newly opened file
	let custom_config_file = expand('%:p:h') . '/.vimrc.custom'
	if filereadable(custom_config_file)
		exe 'source' custom_config_file
	endif
endfunction

" S-Insert and C-S-Insert to paste in insert mode
imap <S-Insert>  <ESC>"+gPa
imap <C-S-Insert>  <ESC>"+gpi

" enable indent guides
if has("gui_running")
	let g:indent_guides_enable_on_vim_startup = 1
endif
map <F3> \ig

call pathogen#infect()

" only checked if you explicitly run :SyntasticCheck
let syntastic_mode_map = { 'passive_filetypes': ['html'] }


