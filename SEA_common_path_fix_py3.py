#! /usr/bin/env python3
# coding:utf-8

import os
import sys
import re
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

def main(fileDir):
    fileList = listFiles(fileDir)
    p1 = r"(?<=content/gameplay/).+?(?=/textures/)"
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