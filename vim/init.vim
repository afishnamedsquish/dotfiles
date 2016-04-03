call pathogen#infect()
call pathogen#helptags()

set mouse=a
syntax enable
set backspace=2
set pastetoggle=<F3>
set t_Co=256
set number
set relativenumber
set nofoldenable
set laststatus=2
set autoread
set scrolloff=3
set cul
set wildmenu
set wildmode=list:longest
set wildignore+=*/.git/*,*.swp,*.jpg,*.png,*.gif,*app/cache/**,*app/logs/**
set visualbell
set clipboard=unnamed
set showcmd
set rtp+=~/.fzf
set splitright
set modeline

" smoother plugins
set lazyredraw

" dont save backups
set nobackup
set nowritebackup
set noswapfile

" Remap leader
let mapleader = ","

" search
set incsearch
set ignorecase
set smartcase
set hlsearch
set tags=tags;/
nmap <silent> <Leader>/ :set hlsearch!<CR>

" indenting
set tw=0
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
filetype plugin indent on

" buffers
set autowrite
set hidden 

" Command mode
nnoremap ; :
vnoremap ; :
nnoremap <Space> ;

" scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Wipe out all buffers
nmap <silent> <Leader>wa :1,9000bwipeout<cr>

" bindings
map <Leader>' :b#<CR>
" map <C-C> "+y
map <Leader>M :%s/<C-V><C-M>//g<CR>
map <Leader>ff :let @+=expand('%:t')<CR>:echo expand('%:t')<CR>
map <Leader>fr :let @+=expand('%')<CR>:echo expand('%')<CR>
map <Leader>fp :let @+=expand('%:p')<CR>:echo expand('%:p')<CR>
map <Leader>sc <ESC>:Scratch<CR>

" unmap dangerous visual mode lowercase
vmap u <Nop>

" Edit common files
nmap <silent> <Leader>ev :e ~/dotfiles/vim/vimrc<CR>
nmap <silent> <Leader>sv :so ~/dotfiles/vim/vimrc<CR>
nmap <silent> <Leader>ssh :e ~/.ssh/config<CR>
nmap <silent> <Leader>bashp :e ~/.bash_profile<CR>
nmap <silent> <Leader>bashr :e ~/.bashrc<CR>

" quickfix
map <Leader>qq <ESC>:cw<CR>
map <Leader>qc <ESC>:ccl<CR>
map <Leader>q] <ESC>:cn<CR>
map <Leader>q[ <ESC>:cp<CR>

" buffer nav
map <Leader>b[ <ESC>:bn<CR>
map <Leader>b] <ESC>:bn<CR>
map <Leader>w[ <ESC>:wp<CR>
map <Leader>w] <ESC>:wn<CR>

" marks
nnoremap ' `
nnoremap ` '

" shell commands
nmap shh q:ir!
nmap shv :vnew<CR>q:ir!
nmap shy :call ShellYank()<CR>

function! ShellYank()
    call inputsave()
    let command = input('Enter a shell command: ')
    let @+ = system(command)
    call inputrestore()
endfunction

" list whitespace
set listchars=tab:▸\ ,eol:¬,trail:¤

" make up/down go to next row in editor instead of next line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" sudo write this
cmap W! w !sudo tee % >/dev/null

" php folding with PHPDoc support
let g:DisableAutoPHPFolding = 1

" Edit another file in the same directory as the current file
cnoremap %% <C-R>=expand('%:p:h')<CR>
map <Leader>ed :e %%/
map <Leader>s :split %%/
map <Leader>v :vnew %%/
nmap <silent> cd :lcd %%<CR>
nmap <silent> md :!mkdir -p %%<CR>

" Fugitive
nnoremap <Leader>gs <ESC>:Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gs :Gstatus<CR>

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes' : ['php'] }
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let s:php_executable = 'php'

" Easy Motion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment

" Color Scheme
set rtp+=~/.vim/bundle/vim-colors-solarized
set background=dark
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
let g:solarized_termcolors=16
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" Autocompletion 
set completeopt=menuone,preview,longest
" let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabLongestHighlight = 1

" VimWiki
let g:vimwiki_list = [{'path': $HOME.'/Dropbox/vimwiki/', 'path_html': $HOME.'/Dropbox/vimwiki/html/'}]

" dont auto insert comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" js highlighting for json files
autocmd BufNewFile,BufRead *.json set ft=javascript

command! -nargs=+ QFDo call QFDo(<q-args>)

" Function that does the work
function! QFDo(command)
    " Create a dictionary so that we can
    " get the list of buffers rather than the
    " list of lines in buffers (easy way
    " to get unique entries)
    let buffer_numbers = {}
    " For each entry, use the buffer number as 
    " a dictionary key (won't get repeats)
    for fixlist_entry in getqflist()
        let buffer_numbers[fixlist_entry['bufnr']] = 1
    endfor
    " Make it into a list as it seems cleaner
    let buffer_number_list = keys(buffer_numbers)

    " For each buffer
    for num in buffer_number_list
        " Select the buffer
        exe 'buffer' num
        " Run the command that's passed as an argument
        exe a:command
        " Save if necessary
        update
    endfor
endfunction

" Unite
" let g:unite_source_grep_command = 'ag'
" let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup'
" let g:unite_source_grep_recursive_opt = '-r'

" let g:unite_source_grep_recursive_opt = ''
" call unite#custom#source('grep', 'ignore_pattern', 'tags|cache|logs|bin|work|node_modules')
let g:unite_source_history_yank_enable = 1
let g:unite_enable_ignore_case = 1
let g:unite_source_rec_max_cache_files = 3000
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec', 'ignore_pattern', '\v(node_modules)|(cache)|(vendor)|(bin)|(work)')
call unite#custom#source('buffer,file_rec/async,file_rec,file_mru', 'matchers', ['converter_tail', 'matcher_default'])
call unite#custom#source('file_rec/async,file_rec,file_mru', 'converters', ['converter_file_directory'])
" nnoremap <C-P> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec:!<cr>
nnoremap <C-F> :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <C-H> :<C-u>Unite -no-split -buffer-name=files   -start-insert file:<C-R>=expand('%:p:h')<cr><cr>
nnoremap <C-B> :<C-u>Unite -no-split -buffer-name=buffers   -start-insert buffer<cr>
nnoremap <leader>ur :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
" nnoremap <C-T> :<C-u>Unite -no-split -buffer-name=tags   -start-insert tag<cr>
" nnoremap <leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <C-Y> :<C-u>Unite -no-split history/yank<cr>
" nnoremap <C-B> :<C-u>Unite -no-split -start-insert buffer<cr>
nnoremap <C-G> :<C-u>Unite -no-split -start-insert grep:.<CR>
nnoremap <C-Q>b :<C-u>Unite -quick-match buffer<cr>
nnoremap <C-K> :<C-u>Unite -no-split -buffer-name=bookmark  -start-insert bookmark<cr>
nnoremap <C-K>a :<C-u>UniteBookmarkAdd<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

autocmd FileType aspx call s:unite_settings()

" Search motion to end of search
vnoremap <silent> S //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap S :normal vs<CR>

au FileType ruby setlocal kp=ri sw=2 ts=2 expandtab
au FileType lisp setlocal sw=2 ts=2 sts=2 sta
au FileType javascript setlocal kp=ri sw=2 ts=2 expandtab
au FileType php setlocal keywordprg=phpd
au BufRead,BufNewFile *.aspx,*.asmx,*.ascx set noexpandtab

set suffixesadd=.js,.php
