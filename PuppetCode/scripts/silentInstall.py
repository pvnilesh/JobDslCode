import argparse
import sys
import os
import subprocess

parser = argparse.ArgumentParser(description="download artifact from Nexus")

parser.add_argument("-l", "--log_file", help="log file to store logs")
parser.add_argument("-p", "--package_file", help=".msi package file")
parser.add_argument("-a", "--argument_file", help="file which contains command line arguments")

args = parser.parse_args()

# need to add validation of arguments
# if package_file,argument_file,or log_file is not specified throw error and quit
if((args.log_file is None) or (args.package_file is None) or (args.argument_file is None)):
  print("At least one required option is missing", file=sys.stderr)
  sys.exit(1)

def run_win_cmd(cmd):
    result = []
    process = subprocess.Popen(cmd,
                               shell=True,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    for line in process.stdout:
        result.append(line)
    errcode = process.returncode
    for line in result:
        print(line)
    if errcode is not None:
        raise Exception('cmd %s failed, see above for details', cmd)  
  
args_file = open(args.argument_file, 'r')
args_str = args_file.read().replace('\n',' ')

final_cmd = "msiexec /qb /l* {} /i {} {}".format(args.log_file,args.package_file,args_str)
print(final_cmd)
run_win_cmd(final_cmd)
