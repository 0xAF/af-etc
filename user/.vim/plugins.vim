
"if !has('nvim')
call pathogen#infect()
"endif



" only checked if you explicitly run :SyntasticCheck
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

let mojo_highlight_data = 1


let g:airline_powerline_fonts = 1
if !exists("g:gui_oni")
let g:airline#extensions#tabline#enabled = 1
endif

"if !exists('g:airline_symbols')
"	let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"

