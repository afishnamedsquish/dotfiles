# TODO Remove shell=True, refactor Popen arg1 into list of args for shell
# TODO Allow for bash to complete globs before they are passsed in instead of requring '*' so it can be passed along to final rsync shell. Pull directory off of first file in that case if there are spaces? Not sure how to split on arguments.. do spaces (since actual spaces will be \ ) but what about arguments in dbl quotes with spaces?
import os
import subprocess
import projectpath

opts = "-rltD --progress --exclude='*.swp' --exclude='*.bak'"
ssh_config_path = os.path.abspath(os.path.expanduser('~/.ssh/config'))

def sync(source, destination, opts=opts):

	source = source.replace(' ', '\ ')
	destination = destination.replace(' ', '\ ')
	cmd = 'rsync ' + opts + ' ' +  source + ' ' + destination
	proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	return proc.communicate()

def project_sync(filename, direction):

	filename = os.path.abspath(os.path.expanduser(filename))
	project_path = projectpath.find(filename)

	if project_path == False:
		return (False, 'Filename ' + filename + ' not in project path')

	# if we are putting and (if its a directory or if the path doesnt exist, send to parent directory on remote)
	remote_filename = filename.replace(project_path + os.path.sep, '')
	if direction == 'put':
		if os.path.isdir(filename) or os.path.exists(filename) == False: 
			remote_filename = os.path.sep.join(remote_filename.split(os.path.sep)[0:-1])

	# TODO Allow for .root-dir to contain project data such as ssh alias
	# Project Alias for SSH is last dir
	project_alias = project_path.split(os.path.sep)[-1].lower()

	remote_filename = project_alias + ':' + remote_filename

	if is_ssh_alias(project_alias):
		if direction == 'put':
			result = sync(filename, remote_filename)
		elif direction == 'get':
			result = sync(remote_filename, filename)
		return (True, result[0])
	else:
		return (False, 'Invalid SSH alias ' + project_alias)

def is_ssh_alias(alias, path=ssh_config_path):

	cmd = "grep -cE '^Host .*" + alias + "( |$)' " + path
	proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	stdout, stderr = proc.communicate()
	return int(stdout.strip())
