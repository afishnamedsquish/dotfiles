# TODO Convert to dirname if isfile, check if startpath exists

import os

def find(start_path, indicator_filename='.root-dir'):
	
	project_path = False
	current_path = os.path.abspath(os.path.expanduser(start_path))
	if (os.path.isfile(current_path)):
		current_path = os.path.dirname(current_path)

	while True:
		
		if os.path.exists(current_path) == False:
			break

		path = os.path.join(current_path, indicator_filename)
		if os.path.exists(path):
			project_path = current_path
			break
		else:
			parent_path = os.path.abspath(os.path.join(current_path, os.path.pardir))

			if parent_path == current_path or os.path.exists(current_path) != True:
				break
			else:
				current_path = parent_path

	return project_path
