
" highlight extra white spaces

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



set bg=dark

