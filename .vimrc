" pathogen
let g:pathogen_disabled = []
call pathogen#infect()
call pathogen#helptags()

set mouse=a
syntax enable
set nobackup
set pastetoggle=<F3>
set t_Co=256
set number

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

" bindings
nnoremap ; :
map <Leader>' :b#<CR>
map <C-C> "+y<CR>
nmap <silent> ,/ :nohlsearch<CR>
map <Leader>M :%s/<C-V><C-M>//g<CR>
map <Leader>ff :let @+=expand('%:t')<CR>:echo expand('%:t')<CR>
map <Leader>fr :let @+=expand('%')<CR>:echo expand('%')<CR>
map <Leader>fp :let @+=expand('%:p')<CR>:echo expand('%:p')<CR>

" comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes' : ['php'] }
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let s:php_executable = 'php'

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

" Lusty Buffer
nmap <Leader>b :LustyJuggler<CR>

" Color Scheme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
" Start NERDTree on launch and focus file
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
"autocmd VimEnter * wincmd w

" Examples
" language specific setting
" autocmd filetype python set expandtab

" Make different whitespace characters visible
" set lines
