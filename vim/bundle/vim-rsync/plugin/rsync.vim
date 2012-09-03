" rsync.vim - A rsync wrapper
" Uses codepath plugin to get the project path for the file
" Assumes the last dir in the project path has an ssh alias we can use for rsync
" Executes an rsync command to transfer the file to the corresponding ssh alias
" TODO Exit if codepath fails
" TODO Exit if there is no actual ssh definition
" TODO Allow for optional host argument to override default behavior of pulling host from end of codepath
" TODO Find a more elegant way to determine if an alias exists. Escape special characters in host (dots)
" TODO codepath plugin currently returns the current dir if the current dir is not in the codepath, not sure this is desirable as it will trigger the last dir of the current dir to be used as the ssh alias.
" Maintainer:   Ben Glassman
" Version:      1.0

let g:rsync_cmd = 'rsync -lt --progress'
let g:ssh_config = '~/.ssh/config'

" Rsync
function! rsync#send()
	let codepath = codepath#path()
	echo codepath
	let path = expand('%:p')

	" If the codepath is not in the file path, exit
	if match(path, codepath) == -1
		echo 'ERROR: File not in the codepath: ' . codepath
		return
	endif

	let remotepath = substitute(path, codepath . '/', '', '')

	let host = split(codepath, '/')[-1]
	if rsync#aliasExists(host)
		let e = '!' . g:rsync_cmd . ' ' . path . ' ' . host . ':' . remotepath
		execute(e)
	else
		echo 'ERROR: SSH alias not found: ' . host
	endif

endfunction

function! rsync#aliasExists(alias)
	let e = "grep -cE '^Host .*" . a:alias . "( |$)' " . g:ssh_config
	let o = system(e)
	return o
endfunction

nmap <Leader>rs :call rsync#send()<CR>
