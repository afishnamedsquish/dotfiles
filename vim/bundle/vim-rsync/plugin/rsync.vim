" rsync.vim - A rsync wrapper
" Uses codepath plugin to get the project path for the file
" Assumes the last dir in the project path has an ssh alias we can use for rsync
" Executes an rsync command to transfer the file to the corresponding ssh alias
" TODO Find a more elegant way to determine if an alias exists. Escape special characters in host (dots)
" TODO codepath plugin currently returns the current dir if the current dir is not in the codepath, not sure this is desirable as it will trigger the last dir of the current dir to be used as the ssh alias.
" TODO Refactor codepath plugin to allow for multiple 'sites' definitions? This allows for ~/sites/ as well as ~/client_sites/
" TODO Add 'path' argument as second optional argument for rsync#send to allow for specification where the file should be dropped
" Maintainer:   Ben Glassman
" Version:      1.0

let g:rsync_cmd = 'rsync -lt --progress'
let g:ssh_config = '~/.ssh/config'

" Rsync
function! rsync#send(alias)
	let codepath = vimpy#project_path()

	if empty(codepath)
		echo 'ERROR: Current directory is not in the codepath'
		return
	endif

	let path = expand('%:p')

	let remotepath = substitute(path, codepath . '/', '', '')

	" If argument 1 is provided
	if empty(a:alias)
		let alias = tolower(split(codepath, '/')[-1])
	else
		let alias = a:alias
	endif

	" If there is an ssh alias defined, send the file
	if rsync#aliasExists(alias)
		let e = '!' . g:rsync_cmd . ' "' . path . '" ' . alias . ':' . remotepath
		execute(e)
	else
		echo 'ERROR: SSH alias not found: ' . alias
	endif

endfunction

function! rsync#aliasExists(alias)
	let e = "grep -cE '^Host .*" . a:alias . "( |$)' " . g:ssh_config
	let o = system(e)
	return o
endfunction

nmap <Leader>rs :call rsync#send('')<CR>
