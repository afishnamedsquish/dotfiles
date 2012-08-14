" pathogen
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

" quickfix
map <Leader>qq <ESC>:cw<CR>
map <Leader>qc <ESC>:ccl<CR>
map <Leader>qn <ESC>:cn<CR>
map <Leader>qp <ESC>:cp<CR>

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
map <C-M> :CtrlPMR<CR>

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

" Lusty Buffer
"nmap <Leader>b :LustyJuggler<CR>

" Toggle QuickFix list
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
nmap <silent> <Leader>` :QFix<CR>

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
