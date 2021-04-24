import os
import hashlib
import sys
import re
import time
import importlib
importlib.reload(sys)
import warnings
warnings.filterwarnings("ignore")
def file_extension(path): 
  return os.path.splitext(path)[1]

def listFiles(dirPath):

    fileList=[]

    for root,dirs,files in os.walk(dirPath):

        for fileObj in files:

            fileList.append(os.path.join(root,fileObj))

    return fileList

def GetFileNameAndExt(filename):
    import os
    (filepath,tempfilename) = os.path.split(filename)
    (shotname,extension) = os.path.splitext(tempfilename)
    return shotname

# sys.setdefaultencoding("utf-8");
def main(fileDir):

    regex = r'FUNC_SYS_ADD_ACCDETAIL'

    fileList = listFiles(fileDir)

    p1 = r"(?<=content/gameplay/).+?(?=/textures/)"
    pattern1 = re.compile(p1)

    for fileObj in fileList:
        if file_extension(fileObj) == '.mfm':
            print(fileObj)
            f=open(fileObj,'r+')
            all_the_lines=f.readlines()
            f.seek(0)
            f.truncate()
            for line in all_the_lines:
                key = line
                newline = re.sub(p1, "common", key)
                f.write(newline) 
            f.close()

main("./")