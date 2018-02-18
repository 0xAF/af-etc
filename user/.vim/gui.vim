" if it is gui
if has("gui_running")
	colorscheme af

	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#292c2c ctermbg=3
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1c1f1f ctermbg=4

	"colorscheme blue
	"set gfn=Terminus\ 14
	"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 13
	"set guifont=Source\ Code\ Pro\ for\ Powerline\ 13
	"set guifont=Terminus\ \(TTF\)\ for\ Powerline\ Medium\ 15
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
	"	let g:af_orig_titlestring = "[" . hostname() . "] %F%<%=%((%m%r)%) [F2 - Help]"
	let g:af_orig_titlestring = "%<%= %((%m%r)%) - [" . hostname() . "] - [F2 - Help]"
	auto BufEnter * let &titlestring = BuildBufferList(0) . g:af_orig_titlestring
	set titlelen=100
	set guioptions=agimrLtbp
	set linespace=1
	"set lines=41 columns=161
	" check columns and lines to get the params for winsize
	"winsize 161 41 " we have it later

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


	let g:indent_guides_enable_on_vim_startup = 1

	" check columns and lines to get the params for winsize
	winsize 161 41


endif

