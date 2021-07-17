import os
import sys
from qgis.core import (
    QgsVectorLayer,
    QgsProject,
    QgsApplication, 
    QgsColorRampShader
)
from glob import glob
from PyQt5 import QtGui
from qgis.core import *
import processing
#time the script
from datetime import datetime
startTime = datetime.now()

#cwd = os.getcwd()
#dirs = cwd + "/data/ppt_pearson_final/"
dirs = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_pearson_final"
all_files = glob(os.path.join(dirs, "*reclassed.tif"))
#coloring from: 
#https://www.gislounge.com/symbolizing-vector-and-raster-layers-qgis-python-programming-cookbook/
for i in all_files:
  #get basename of each tif
  tiff_basename = os.path.basename(i)
  #strip .tif off the i variable
  basename = tiff_basename[:-4]
  #clip the raster with OR shapefile
  #create layer
  rlayer = QgsRasterLayer(i, basename)
  if rlayer.isValid():
     print("loaded")
  else:
    print("failed to load")
  #raster shader and ramp shader objects
  s = QgsRasterShader()
  c = QgsColorRampShader()
  c.setColorRampType(QgsColorRampShader.Interpolated)
  #list to hold color ramp definition and append color ramp values
  j = []
  j.append(QgsColorRampShader.ColorRampItem(0, QtGui.QColor(0,0,0,0), "0"))
  j.append(QgsColorRampShader.ColorRampItem(1, QtGui.QColor("#d1e3f3"), "1"))
  j.append(QgsColorRampShader.ColorRampItem(2, QtGui.QColor("#9ac8e1"), "2"))
  j.append(QgsColorRampShader.ColorRampItem(3, QtGui.QColor("#529dcc"), "3"))
  j.append(QgsColorRampShader.ColorRampItem(4, QtGui.QColor("#1c6cb1"), "4"))
  j.append(QgsColorRampShader.ColorRampItem(5, QtGui.QColor("#08306b"), "5"))
  #assign color ramp and use raster shaders color ramp
  c.setColorRampItemList(j)
  s.setRasterShaderFunction(c)
  #raster renter object, asign renderer to layer, add to map
  ps = QgsSingleBandPseudoColorRenderer(rlayer.dataProvider(), 1, s)
  rlayer.setRenderer(ps)
  QgsProject.instance().addMapLayer(rlayer)
  #setup html file output
  basename = tiff_basename[:-14]
  output_dir = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_cor_xyz/ppt_cor_xyz_" + basename
  html = ".html"
  output_html = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_cor_xyz/ppt_cor_xyz_" + basename + html
  #make dir to hold each tile file
  os.mkdir(output_dir)
  print("created dir " + basename)
  #run qgis:tilesxyzdirectory processing algorithm
  processing.run("qgis:tilesxyzdirectory", {'EXTENT': '-125.020833333,-66.479166667,24.062500000,49.937500000 [EPSG:4269]',
  'ZOOM_MIN': 2,
  'ZOOM_MAX': 6,
  'DPI': 96,
  'TILE_FORMAT': 0,
  'TILE_WIDTH': 256,
  'TILE_HEIGHT': 256,
  'OUTPUT_DIRECTORY': output_dir,
  'OUTPUT_HTML': output_html
  })
  print(i + " has been xyzed")
  #remove layers and start over
  QgsProject.instance().removeAllMapLayers()

#QgsApplication.exitQgis()

endTime = datetime.now()
finalTime = endTime - startTime
print("Took this long to run ppt_tif2ZYX.py: " + str(finalTime))


