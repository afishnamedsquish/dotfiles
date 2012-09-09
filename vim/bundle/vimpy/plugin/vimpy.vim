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

function! vimpy#rsync_file_to_project()

python << endpython

import os
import vim
import sys

sys.path.append(os.path.join(os.path.expanduser('~'), 'dotfiles/python'))
import rsync

source = vim.eval("expand('%:p')")

response = rsync.send_to_project(source)
return_response = response[1]

vim.command("return '" + return_response + "'")

endpython

endfunction

map <Leader>rs :echo vimpy#rsync_file_to_project()<CR>
