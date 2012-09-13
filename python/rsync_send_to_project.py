import argparse
import rsync

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument('source')
# nargs on a postional argument can allow it to be optional, in this case ? means use 1 value if available otherwise use the default
parser.add_argument('direction', default='put', choices=['put', 'get'], nargs='?')
args = parser.parse_args()

result = rsync.project_sync(args.source, args.direction)

if __name__ == '__main__':
	print result[1]
