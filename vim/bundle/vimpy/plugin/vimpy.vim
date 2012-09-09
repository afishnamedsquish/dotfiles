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
