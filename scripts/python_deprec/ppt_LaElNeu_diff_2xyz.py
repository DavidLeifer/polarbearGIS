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
dirs = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_lanina_minus_neutral"
all_files = glob(os.path.join(dirs, "*.tif"))
#coloring from: 
#https://www.gislounge.com/symbolizing-vector-and-raster-layers-qgis-python-programming-cookbook/
for i in all_files:
  #get basename of each tif
  tiff_basename = os.path.basename(i)
  #strip .tif off the i variable
  basename = tiff_basename[:-4]
  print(basename)
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
  j.append(QgsColorRampShader.ColorRampItem(-100, QtGui.QColor("#f7fcf5"), "-100"))
  j.append(QgsColorRampShader.ColorRampItem(-40, QtGui.QColor("#caeac3"), "-40"))
  j.append(QgsColorRampShader.ColorRampItem(20, QtGui.QColor("#7bc87c"), "20"))
  j.append(QgsColorRampShader.ColorRampItem(80, QtGui.QColor("#2a924a"), "80"))
  j.append(QgsColorRampShader.ColorRampItem(140, QtGui.QColor("#00441b"), "140"))
  #assign color ramp and use raster shaders color ramp
  c.setColorRampItemList(j)
  s.setRasterShaderFunction(c)
  #raster renter object, asign renderer to layer, add to map
  ps = QgsSingleBandPseudoColorRenderer(rlayer.dataProvider(), 1, s)
  rlayer.setRenderer(ps)
  QgsProject.instance().addMapLayer(rlayer)
  #setup html file output
  output_dir = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_lanina_minus_neutral_xyz/"
  html = ".html"
  output_html = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_lanina_minus_neutral_xyz/" + html
  #make dir to hold each tile file
  os.mkdir(output_dir)
  print("created dir " + basename)
  #run qgis:tilesxyzdirectory processing algorithm

  processing.run("qgis:tilesxyzdirectory", {'EXTENT': '-125.0208333333333570,-66.4791666666198608,24.0624999999790532,49.9374999999997513 [EPSG:4326]',
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
