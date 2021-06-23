#! /usr/bin/env python3
# coding:utf-8

import os
import sys
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

# sys.setdefaultencoding("utf-8");
def main(fileDir):
    fileList = listFiles(fileDir)
    for fileObj in fileList:
        if file_extension(fileObj) == '.mfm':
            print(fileObj)
            f=open(fileObj,'r+')
            all_the_lines=f.readlines()
            f.seek(0)
            f.truncate()
            for line in all_the_lines:
                f.write(line.replace('shaders/std_effects/ship_material.fx','shaders/materials/pbs/ship_material.fx')\
                    .replace('shaders/std_effects/ship_material_skinned.fx','shaders/materials/pbs/ship_material_skinned.fx')\
                    .replace('shaders/std_effects/wire_material.fx','shaders/materials/pbs/wire_material.fx')\
                    .replace('shaders/std_effects/glass_material.fx','shaders/materials/pbs/glass_material.fx')\
                    .replace('shaders/std_effects/ship_nodamage_material.fx','shaders/materials/pbs/ship_nodamage_material.fx')) 
            f.close()

main("./")