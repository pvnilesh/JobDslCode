import argparse
import sys
import urllib.request
import json
import os
from distutils.version import LooseVersion

parser = argparse.ArgumentParser(description="download artifact from Nexus")

parser.add_argument("-g", "--group_id", help="group id of artifact")
parser.add_argument("-a", "--artifact_id", help="artifact id of artifact")
parser.add_argument("-v", "--version", help="version of artifact", default="LATEST")
parser.add_argument("-r", "--repository", help="repository name")
parser.add_argument("-e", "--extension", help="extension used; war,ear,jar")
parser.add_argument("-n", "--nexus_url", help="nexus server url")
parser.add_argument("-u", "--username", help="username of nexus user", default="admin")
parser.add_argument("-p", "--password", help="password of nexus user", default="admin123")
parser.add_argument("-t", "--target_folder", help="target folder to store artifact")

args = parser.parse_args()

# need to add validation of arguments
# if group_id,artifact_id,repository,nexus_url or extension is not specified throw error and quit
if((args.group_id is None) or (args.artifact_id is None) or (args.repository is None) or (args.nexus_url is None) or (args.extension is None) or (args.target_folder is None)):
  print("At least one required option is missing", file=sys.stderr)
  sys.exit(1)

# target folder to store the artifact
target_loc = args.target_folder  

# temp folder to store temp files
temp_loc = target_loc


# build Nexus REST API url
rest_url = "http://" + args.nexus_url + "/service/siesta/rest/beta/search/assets?repository=" + args.repository + "&group=" + args.group_id + "&name=" + args.artifact_id + "&maven.extension=" + args.extension

# get Python LooseVersion of the artifact
def getVersion(myitem):
  str = myitem["path"].split("/")[-2]
  return LooseVersion(str)
 
# get item/component array for particular ret_url
def getItemArray():
  out_file = "{}\\out.json".format(temp_loc)
  urllib.request.urlretrieve(rest_url,out_file)
  outfile = open(out_file,'r')
  data = json.load(outfile)
  outfile.close()
  it_array = data["items"]
  if len(it_array) == 0:
    print("No asset found")
    sys.exit(1)
  return it_array

# sort the item arrray based on the LooseVersion
def sortItemArray(i_arr):
  sort_i_arr = sorted(i_arr, key=lambda item: getVersion(item))
  sort_dict = { "items": [], "continuationToken" : "null" }
  sort_dict["items"] = sort_i_arr  
  sort_out_file = open("{}\\sort_out.json".format(temp_loc),'w')
  json.dump(sort_dict, sort_out_file)
  sort_out_file.close()
  return sort_i_arr
 
# get the download url of the artifact 
def getDownloadUrl(ite_array):
  #print(ite_array[-1]["downloadUrl"])
  return ite_array[-1]["downloadUrl"]
  

# download the artifact to given location
def saveArtifact(d_url,t_loc):
  urllib.request.urlretrieve(d_url,"{}\\{}.{}".format(t_loc,args.artifact_id,args.extension))  
 
#print("group id = {}".format(args.group_id))


if args.version.upper() == "LATEST":
  item_array = getItemArray()
  sorted_item_array = sortItemArray(item_array)
  down_url = getDownloadUrl(sorted_item_array)
  saveArtifact(down_url, target_loc)  
else:
  rest_url = rest_url + "&version=" + args.version
  item_array = getItemArray()
  down_url = getDownloadUrl(item_array)
  saveArtifact(down_url, target_loc)
 