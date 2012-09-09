import argparse
import rsync

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument('source')
args = parser.parse_args()

print rsync.send_to_project(args.source)
