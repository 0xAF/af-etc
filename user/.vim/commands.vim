
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

vnoremap ;bc "ey:call CalcBC()<CR>
function! CalcBC()
	let has_equal = 0
	" remove newlines and trailing spaces
	let @e = substitute (@e, "\n", "", "g")
	let @e = substitute (@e, '\s*$', "", "g")
	" if we end with an equal, strip, and remember for output
	if @e =~ "=$"
		let @e = substitute (@e, '=$', "", "")
		let has_equal = 1
	endif
	" sub common func names for bc equivalent
	let @e = substitute (@e, '\csin\s*(', "s (", "")
	let @e = substitute (@e, '\ccos\s*(', "c (", "")
	let @e = substitute (@e, '\catan\s*(', "a (", "")
	let @e = substitute (@e, "\cln\s*(", "l (", "")
	" escape chars for shell
	let @e = escape (@e, '*()')
	" run bc, strip newline
	let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
	" append answer or echo
	if has_equal == 1
		normal `>
		exec "normal a" . answer
	else
		echo "answer = " . answer
	endif
endfunction

