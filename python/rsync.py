# TODO Remove shell=True, refactor Popen arg1 into list of args for shell
import os
import subprocess
import projectpath

opts = "-rltD --progress --exclude='*.swp' --exclude='*.bak'"
ssh_config_path = os.path.abspath(os.path.expanduser('~/.ssh/config'))

def send(source, destination, ssh_alias, opts=opts):

	source = source.replace(' ', '\ ')
	destination = destination.replace(' ', '\ ')
	cmd = 'rsync ' + opts + ' ' +  source + ' ' + ssh_alias + ':' + destination
	proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	return proc.communicate()

def send_to_project(source):

	source = os.path.abspath(os.path.expanduser(source))
	project_path = projectpath.find(source)

	if project_path == False:
		return (False, 'Source ' + source + ' not in project path')

	# if its a directory or if the path doesnt exist, send to parent directory on remote
	remote_path = source.replace(project_path + os.path.sep, '')
	if os.path.isdir(source) or os.path.exists(source) == False: 
		remote_path = os.path.sep.join(remote_path.split(os.path.sep)[0:-1])

	# TODO Allow for .root-dir to contain project data such as ssh alias
	# Project Alias for SSH is last dir
	project_alias = project_path.split(os.path.sep)[-1]

	if is_ssh_alias(project_alias):
		result = send(source, remote_path, project_alias)
		return (True, result[0])
	else:
		return (False, 'Invalid SSH alias ' + project_alias)

def is_ssh_alias(alias, path=ssh_config_path):

	cmd = "grep -cE '^Host .*" + alias + "( |$)' " + path
	proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
	stdout, stderr = proc.communicate()
	return int(stdout.strip())
