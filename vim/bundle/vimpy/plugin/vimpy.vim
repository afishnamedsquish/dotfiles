" Get project path using python

function! vimpy#project_path()

python << endpython

import os
import vim
import sys

sys.path.append(os.path.join(os.path.expanduser('~'), 'dotfiles/python'))
import projectpath

start_path = vim.eval("getcwd()")

path = projectpath.find(start_path)
if path != False:
	return_path = path
else:
	return_path = '0'

vim.command("return '" + return_path + "'")

endpython

endfunction

" Rsync files to project

function! vimpy#rsync_project(direction)

python << endpython

import os
import vim
import sys

sys.path.append(os.path.join(os.path.expanduser('~'), 'dotfiles/python'))
import rsync

source = vim.eval("expand('%:p')")

response = rsync.project_sync(source, vim.eval("a:direction"))
return_response = response[1]

vim.command("return '" + return_response + "'")

endpython

endfunction

map <Leader>rp :echo vimpy#rsync_project('put')<CR>
map <Leader>rg :echo vimpy#rsync_project('get')<CR>:e!<CR>

" TODO Fix macvim issue with using vimpy#rsync_project to avoid the need to call the python script directly
map <Leader>rsp :echo system('python ~/dotfiles/python/rsync_send_to_project.py "' . expand('%:p') . '" put')
map <Leader>rsg :echo system('python ~/dotfiles/python/rsync_send_to_project.py "' . expand('%:p') . '" get')
