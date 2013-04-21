set omnifunc=phpcomplete#CompletePHP

" PHP Namespace
imap <buffer> <Leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <Leader>u :call PhpInsertUse()<CR>
imap <buffer> <Leader>e <C-O>:call PhpExpandClass()<CR>
map <buffer> <Leader>e :call PhpExpandClass()<CR>

" pdv - PHPDocumenter
imap <Leader>d <ESC>:call PhpDocSingle()<CR>i 
nmap <Leader>d :call PhpDocSingle()<CR> 
vmap <Leader>d :call PhpDocRange()<CR> 

" Folding
"set foldlevelstart=1
"EnableFastPHPFolds
