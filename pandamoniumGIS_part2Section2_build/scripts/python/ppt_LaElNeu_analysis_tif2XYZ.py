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

'''
Try this: https://stackoverflow.com/questions/64678135/segmentation-fault-11-when-using-initqgis-macos
#https://gis.stackexchange.com/questions/123251/calling-qgis-from-macos-python
#https://docs.qgis.org/3.4/en/docs/pyqgis_developer_cookbook/intro.html
#run in command line
#export QT_QPA_PLATFORM_PLUGIN_PATH=/Applications/QGIS.app/Contents/PlugIns

# Supply path to qgis install location
QgsApplication.setPrefixPath("/Applications/QGIS.app/Contents/Resources/python/plugins", True)
# Create a reference to the QgsApplication.  Setting the
# second argument to False disables the GUI.
qgs = QgsApplication([], False)
# Load providers
qgs.initQgis()
'''

import processing

#time the script
from datetime import datetime
startTime = datetime.now()

#cwd = os.getcwd()
#dirs = cwd + "/data/ppt_pearson_final/"
dirs = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS_part2Section2_build/data/ppt_bil2tif_LaElNeu_analysis"
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
  j.append(QgsColorRampShader.ColorRampItem(3, QtGui.QColor("#f7fbff"), "3"))
  j.append(QgsColorRampShader.ColorRampItem(90, QtGui.QColor("#deebf7"), "90"))
  j.append(QgsColorRampShader.ColorRampItem(176, QtGui.QColor("#c6dbef"), "176"))
  j.append(QgsColorRampShader.ColorRampItem(263, QtGui.QColor("#9ecae1"), "263"))
  j.append(QgsColorRampShader.ColorRampItem(350, QtGui.QColor("#6baed6"), "350"))
  j.append(QgsColorRampShader.ColorRampItem(437, QtGui.QColor("#4292c6"), "437"))
  j.append(QgsColorRampShader.ColorRampItem(524, QtGui.QColor("#2171b5"), "524"))
  j.append(QgsColorRampShader.ColorRampItem(604, QtGui.QColor("#08519c"), "604"))
  j.append(QgsColorRampShader.ColorRampItem(670, QtGui.QColor("#08306b"), "670"))
  #assign color ramp and use raster shaders color ramp
  c.setColorRampItemList(j)
  s.setRasterShaderFunction(c)
  #raster renter object, asign renderer to layer, add to map
  ps = QgsSingleBandPseudoColorRenderer(rlayer.dataProvider(), 1, s)
  rlayer.setRenderer(ps)
  QgsProject.instance().addMapLayer(rlayer)
  #setup html file output
  output_dir = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS_part2Section2_build/data/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_" + basename
  html = ".html"
  output_html = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS_part2Section2_build/data/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_" + basename + html
  #make dir to hold each tile file
  #os.mkdir(output_dir)
  #print("created dir " + basename)
  #run qgis:tilesxyzdirectory processing algorithm

  processing.run("qgis:tilesxyzdirectory", {'EXTENT': '-125.020833333,-66.479166667,24.062500000,49.937500000 [EPSG:4269]',
  'ZOOM_MIN': 2,
  'ZOOM_MAX': 3,
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
print("Took this long to run ppt_LaElNeu_analysis_tif2XYZ.py: " + str(finalTime))


