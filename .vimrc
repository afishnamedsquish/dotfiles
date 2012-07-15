set mouse=a
syntax enable
set nobackup
set pastetoggle=<F3>

" search
set ignorecase
set smartcase
set hlsearch
set tags=tags;/

" indenting
set smartindent
set tabstop=4
set shiftwidth=4
filetype plugin indent on

" buffers
set autowrite
set hidden 

" pathogen
let g:pathogen_disabled = ['tComment','taglist.vim']
call pathogen#infect()
call pathogen#helptags()

" bindings
nnoremap ; :
map <Leader>' :b#<CR>
map <C-C> "+y<CR>
nmap <silent> ,/ :nohlsearch<CR>

" make up/down go to next row in editor instead of next line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

"Markdown to HTML  
nmap <Leader>md :%!/usr/local/bin/Markdown.pl --html4tags <CR>

" Nerd Tree
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25

" Nerd Commenter
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle 

" php folding with PHPDoc support
let g:DisableAutoPHPFolding = 1
map <F6> <Esc>:EnableFastPHPFolds<CR>

" taglist
map <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" pdv - PHPDocumenter
imap <Leader>d <ESC>:call PhpDocSingle()<CR>i 
nmap <Leader>d :call PhpDocSingle()<CR> 
vmap <Leader>d :call PhpDocRange()<CR> 

" CtrlP
let g:ctrlp_root_markers = ['.root-dir']
let g:ctrlp_working_path_mode = 2
map <C-B> :CtrlPBuffer<CR>

:colorscheme jellybeans
" Start NERDTree on launch and focus file
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
"autocmd VimEnter * wincmd w

" Examples
" language specific setting
" autocmd filetype python set expandtab

" Make different whitespace characters visible
" set lines
