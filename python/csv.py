def showFields(fields):
	import vim
	import csv
	reader = csv.reader(vim.current.buffer, delimiter=',')
	for row in reader:
		print [ value for field, value in enumerate(row) if field in fields ]

