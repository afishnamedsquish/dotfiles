let g:pathogen_disabled = ['lusty', 'csapprox']
call pathogen#infect()
call pathogen#helptags()

set mouse=a
syntax enable
set nobackup
set noswapfile
set pastetoggle=<F3>
set t_Co=256
set number
set nofoldenable
set laststatus=2
set autoread

" System default for mappings is now the "," character
let mapleader = ","

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
" Wipe out all buffers
nmap <silent> <Leader>wa :1,9000bwipeout<cr>

" bindings
nnoremap ; :
vnoremap ; :
map <Leader>' :b#<CR>
map <C-C> "+y<CR>
nmap <silent> ,/ :nohlsearch<CR>
map <Leader>M :%s/<C-V><C-M>//g<CR>
map <Leader>ff :let @+=expand('%:t')<CR>:echo expand('%:t')<CR>
map <Leader>fr :let @+=expand('%')<CR>:echo expand('%')<CR>
map <Leader>fp :let @+=expand('%:p')<CR>:echo expand('%:p')<CR>
map <Leader>s <ESC>:Scratch<CR>

" Edit the vimrc file
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>

" Try jj for esc
imap jj <esc>

" comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" quickfix
map <Leader>qq <ESC>:cw<CR>
map <Leader>qc <ESC>:ccl<CR>
map <Leader>q] <ESC>:cn<CR>
map <Leader>q[ <ESC>:cp<CR>

" move lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" wrap
map <Leader>wr <ESC>:set wrap!<CR>

" list whitespace
map <Leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

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
let NERDCreateDefaultMappings = 0
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle 

" Tabs
map <Leader>wt <C-W>T
map <Leader>tc :tabc<CR>
map <Leader>te :tabe 
map <Leader>to :tabo<CR>
map <M-]> gt
map <M-[> gT
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-0> :tablast<CR>

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

" Easy Motion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

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
