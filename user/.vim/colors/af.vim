" Vim color file
" Maintainer: Stanislav Lechev [AngelFire] <af@0xAF.org>
" Last Change: 2013/04/19
" Info: based on desert and a little bit of gothic
" Version: 1.1

set background=dark
if version > 580
	hi clear
		if exists("syntax_on")
		syntax reset
	endif
endif
let g:colors_name="af"
set statusline=%<%1*===\ %5*%f%1*%(\ ===\ %4*%h%1*%)%(\ ===\ %4*%m%1*%)%(\ ===\ %4*%r%1*%)\ ===%====\ %2*%b(0x%B)%1*\ ===\ %3*%l,%c%V%1*\ ===\ %5*%P%1*\ ===%0* laststatus=2

hi User1	guifg=yellow		guibg=darkblue
hi User2	guifg=lightblue		guibg=darkblue
hi User3	guifg=red   		guibg=darkblue
hi User4	guifg=cyan  		guibg=darkblue
hi User5	guifg=lightgreen	guibg=darkblue

hi Normal	guifg=#cff		guibg=#030707
hi Cursor	guifg=slategrey		guibg=khaki
hi Comment	guifg=#808080
hi Identifier	guifg=#87def0				gui=bold
hi Constant	guifg=#FF99FF
"hi String	guifg=#FF5599
hi String	guifg=#ff8080
hi Character	guifg=#87cee0
hi Statement	guifg=khaki
hi PreProc	guifg=red
hi Type		guifg=lightgreen			gui=none
hi Todo		guifg=orangered		guibg=yellow2
hi Special	guifg=Orange
hi Visual	guifg=SkyBlue		guibg=grey60	gui=none
hi IncSearch	guifg=#ffff60		guibg=#0000ff	gui=none
hi Search	guifg=khaki		guibg=slategrey	gui=none
hi Ignore	guifg=grey40

hi VertSplit	guifg=grey50		guibg=#c2bfa5	gui=none
hi Folded	guifg=gold              guibg=grey30
hi FoldColumn	guifg=tan               guibg=grey30
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue		guibg=#000000
hi Question	guifg=springgreen
hi SpecialKey	guifg=yellowgreen
hi StatusLineNC	guifg=grey50		guibg=#c2bfa5	gui=none
hi Title	guifg=indianred
hi WarningMsg	guifg=salmon

hi IndentGuidesOdd			guibg=#292c2c
hi IndentGuidesEven			guibg=#1c1f1f

" these are from desert ... i didn't change it
" color terminal definitions
if &t_Co > 255
	hi SpecialKey	ctermfg=darkgreen
	hi NonText	ctermfg=darkblue			cterm=bold
	hi Directory	ctermfg=darkcyan
	hi ErrorMsg	ctermfg=7		ctermbg=1	cterm=bold
	hi IncSearch	ctermfg=yellow		ctermbg=green	cterm=none
	hi Search	ctermfg=grey		ctermbg=blue	cterm=none
	hi MoreMsg	ctermfg=darkgreen
	hi ModeMsg	ctermfg=brown				cterm=none
	hi LineNr	ctermfg=3
	hi Question	ctermfg=green
	hi StatusLine						cterm=bold,reverse
	hi StatusLineNC						cterm=reverse
	hi VertSplit						cterm=reverse
	hi Title	ctermfg=5
	hi Visual						cterm=reverse
	hi VisualNOS						cterm=bold,underline
	hi WarningMsg	ctermfg=1
	hi WildMenu	ctermfg=0		ctermbg=3
	hi Folded	ctermfg=darkgrey	ctermbg=none
	hi FoldColumn	ctermfg=darkgrey	ctermbg=none
	hi DiffAdd				ctermbg=4
	hi DiffChange				ctermbg=5
	hi DiffDelete	ctermfg=4		ctermbg=6	cterm=bold
	hi DiffText				ctermbg=1	cterm=bold
	hi Comment	ctermfg=darkcyan
	hi Constant	ctermfg=brown
	hi Special	ctermfg=5
	hi Identifier	ctermfg=6
	hi Statement	ctermfg=3
	hi PreProc	ctermfg=5
	hi Type		ctermfg=2
	hi Underlined	ctermfg=5				cterm=underline
	hi Ignore	ctermfg=7				cterm=bold
	hi Error	ctermfg=7		ctermbg=1	cterm=bold
end

