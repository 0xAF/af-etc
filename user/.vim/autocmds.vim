" autocmd's

" vimrc_on_the_fly from vimcasts
" autocmd bufwritepost .vimrc source $MYVIMRC

" always save the buffer when loosing the focus
"autocmd FocusLost * :wa

" shell script editing
augroup sh
	autocmd FileType sh let g:sh_fold_enabled=1
	autocmd FileType sh let g:is_bash=1
	autocmd FileType sh set foldmethod=syntax
augroup END


" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
"autocmd BufRead *.txt set tw=78

" color in red everything after the 80'th char
"au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)


au FileType html,xhtml,tt2html,html.epl setlocal tabstop=2 shiftwidth=2 softtabstop=2 sidescroll=2
au FileType perl,js,jquery setlocal tabstop=4 shiftwidth=4 softtabstop=4 sidescroll=4 noet

" epl (Embedded Perl - Mojolicious)
au FileType epl imap <C-Space> <%=  =%><ESC>hhhha




autocmd BufEnter * silent! lcd %:p:h
"autocmd BufEnter * :cd %:p:h

" for gopass
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile


" write the viminfo file (don't know why it's written only when quiting vim)
au BufDelete * wv


autocmd Syntax * call SyntaxRange#Include('.*@begin=html@', '.*@end=html@', 'html', 'NonText') 
autocmd Syntax * call SyntaxRange#Include('.*@begin=javascript@', '.*@end=javascript@', 'javascript', 'NonText') 



"autocmd FileType perl set fp=perltidy\ -w\ -b\ -ole=unix\ -csc\ -ce\ -et=4
"autocmd FileType perl map <C-i> :%!perltidy -w -b -ole=unix -csc -ce -et=4<CR>
" autocmd FileType c,cpp map <C-i> :%!indent -kr -l78 -lc78 -bap -bbb -nbbo -br -brs -bs -cdb -cs -nbfda -ut -i8 -pcs -npsl -saf -sai -saw -ss -ts8 -nfca -npcs -nprs -ppi2 <CR>
" autocmd FileType c,cpp map <C-i> :%!indent<CR>

augroup markdown
	" Markdown (no need for modula2 :)
	autocmd BufRead,BufNewFile *.md set filetype=markdown
	autocmd FileType markdown set wrap linebreak nolist
	autocmd FileType markdown set textwidth=0
	autocmd FileType markdown set wrapmargin=0
	autocmd FileType markdown nmap <leader>m :silent !open %<CR>
	" http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
	" http://stackoverflow.com/questions/5074191/vim-fold-top-level-folds-only
	autocmd FileType markdown normal %foldc
augroup END

" http://stackoverflow.com/questions/26962999/wrong-indentation-when-editing-yaml-in-vim
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


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




