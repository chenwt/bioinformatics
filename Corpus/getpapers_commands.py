#!/usr/local/bin/python
import argparse
import os
import sys

## sample: ./getpapers_commands.py --keyword "RNAseq" --startyear 2000 --endyear 2017
parser = argparse.ArgumentParser()

parser.add_argument("--keyword", help="A main keyword", action="store", dest="keyword")
parser.add_argument("--startyear", help="Start year [default: %(default)s]", action="store", type=int, dest="startyear")
parser.add_argument("--endyear", help="End year [default: %(default)s]", action="store", type=int, dest="endyear")

parser.add_argument('--split', help="Split downloading by a publication year [default]", dest='split', action='store_true')
parser.add_argument('--no-split', help="Do not split downloading by a publication year", dest='split', action='store_false')
parser.set_defaults(split=True)

parser.add_argument('--run', help="Run the generated script. security risk!", dest='run', action='store_true')
parser.add_argument('--no-run', help="Do run the generated script [default]", dest='run', action='store_false')
parser.set_defaults(run=False)

args = parser.parse_args()

filename1 = "getpapers_" +str(args.keyword)+ ".sh"
if os.path.isfile(filename1):
	sys.exit("This file/command already exist. Please check the current directory.")

if args.split is True:
	f = open(filename1,"w")

	for i in xrange(args.startyear, args.endyear):
		f.write("getpapers -q \'(BODY:\"" +str(args.keyword)+ "\") "
		"AND (PUB_TYPE:\"Journal Article\" OR PUB_TYPE:\"article-commentary\" OR PUB_TYPE:\"research-article\" OR PUB_TYPE:\"protocol\" OR PUB_TYPE:\"rapid-communication\") AND (LANG:\"eng\" OR LANG:\"en\" OR LANG:\"us\") AND "
		"(FIRST_PDATE:[" +str(i)+ "-01-01 TO " +str(i)+ "-12-31])' "
		"-o " +str(args.keyword)+str(i)+ " -x\n\n")

	f.close()
		
	cmd = "chmod u+x " +filename1
	os.system(cmd)
	if args.run:
		subprocess.call(filename1, shell=True)
else:
	f = open(filename1,"w")

	f.write("getpapers -q \'(BODY:\"" +str(args.keyword)+ "\") "
	"AND (PUB_TYPE:\"Journal Article\" OR PUB_TYPE:\"article-commentary\" OR PUB_TYPE:\"research-article\" OR PUB_TYPE:\"protocol\" OR PUB_TYPE:\"rapid-communication\") AND (LANG:\"eng\" OR LANG:\"en\" OR LANG:\"us\")\' "
	"-o " +str(args.keyword)+ " -x\n")

	f.close()

	cmd = "chmod u+x " +filename1
	os.system(cmd)
	if args.run:
		subprocess.call(filename1, shell=True)