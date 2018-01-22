" general mappings


" <space> is easier than \
let mapleader = " "

" toggle numbers (e.g. for copy and paste to another window)
nmap <leader>tn :set relativenumber!<CR>

" show invisible chars (*t*oggle *l*ist)
nmap <leader>tl :set list!<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" reselect just pasted text
nnoremap <leader>v V`]


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

map <S-Tab>	:!(cd %:p:h;exuberant-ctags *.[ch] *.cpp *.cc)&<CR>

"nnoremap  \  <C-^>

" in insert mode Ctrl-Space/Ctrl-BackSpace act as Ctrl-n/Ctrl-p
" for word compleation
"imap <C-Space> <C-n>
"imap <C-BS> <C-p>
"imap <C-Space> <C-x><C-o>

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


" S-Insert and C-S-Insert to paste in insert mode
imap <S-Insert>  <ESC>"+gPa
imap <C-S-Insert>  <ESC>"+gpi


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

map <F3> <leader>ig

map <F4> :NERDTreeToggle<CR>

" Toggle spelling
noremap <F11> :setlocal spell!<CR>

" Panic Button
noremap <F12> ggg?G``:set rl!<CR>

" Now one can press enter in normal mode to insert an empty line.
":nmap <enter> _i<enter><esc>
:nmap <enter> i<enter><esc>

" this maps space to ctrl-d in esc mode
:nmap <SPACE> <C-d>

" ctrl-q - :q!
:nmap <C-q> :q!<CR>


" when you are in visual mode and press down/up with shift
" it behaves like PgDown/PgUp (which is annoying)
vmap <S-Down> <Down>
vmap <S-Up> <Up>

"map <C-d> ,c<SPACE>

"Surround code with braces in visual
vmap <Leader>{} c{<ESC>pgv=


" \l in visual - convert *selected* to <%=l '*selected*'%>, for use with mojo's ep
vmap <leader>l :s/\%V\(.*\)\%V/<%=l '\1'%>/<CR>:let @/ = ""<CR>``

