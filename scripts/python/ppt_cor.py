import rasterio
import fiona
from shapely.geometry import shape
import rasterio.mask
import rasterio.features
import geopandas as gp
import numpy as np
import pandas as pd
import pyproj
import seaborn as sns
import scipy.stats as stats
from glob import glob
from osgeo import ogr, gdal, osr
from osgeo.gdalnumeric import *
from osgeo.gdalconst import *

from rasterio.warp import calculate_default_transform, reproject, Resampling

import os
import sys
'''
from qgis.core import (
    QgsVectorLayer,
    QgsProject,
    QgsColorRampShader
)

#https://gis.stackexchange.com/questions/123251/calling-qgis-from-macos-python
#https://docs.qgis.org/3.4/en/docs/pyqgis_developer_cookbook/intro.html

from PyQt5 import QtGui
from qgis.core import *

#run in command line
#export QT_QPA_PLATFORM_PLUGIN_PATH=/Applications/QGIS3.app/Contents/PlugIns

# Supply path to qgis install location
QgsApplication.setPrefixPath("/Applications/QGIS.app/Contents/Resources/python/plugins", True)
# Create a reference to the QgsApplication.  Setting the
# second argument to False disables the GUI.
qgs = QgsApplication([], False)
# Load providers
qgs.initQgis()

import processing
#https://gis.stackexchange.com/questions/152762/error-algorithm-not-found-qgis
#from processing.core.Processing import Processing
#Processing.initialize()
'''

#get current working dir
cwd = os.getcwd()
#read in index
df = pd.read_excel(cwd + '/data/nino34.xlsx', sheet_name='Sheet1')
ppt_data_dir = cwd + '/data/ppt/'
ppt_file_list = glob(os.path.join(ppt_data_dir, '*.bil'))
example_tif = cwd + "/data/ppt_bil2tif_resize_1981.tif"
#used to set gdal transform way down in the for loop
data0 = gdal.Open(example_tif)
vectorize_output = cwd + "/data/timeseries_19910101_shp_mask/timeseries_19910101_shp_mask.shp"
'''#https://docs.qgis.org/3.16/en/docs/user_manual/processing_algs/gdal/rasterconversion.html#id17
example_tif = '/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/timeseries_19910101.tif'
vectorize_output = '/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/timeseries_19910101_shp_mask/timeseries_19910101_shp_mask.shp'
#https://gis.stackexchange.com/questions/52705/how-to-write-shapely-geometries-to-shapefiles
#Vectorize Raster, this is to clip index rasters
processing.run("gdal:polygonize", {
  'INPUT': example_tif,
  'BAND': 1,
  'FIELD': "DN",
  'EIGHT_CONNECTEDNESS': False,
  'EXTRA': None,
  'OUTPUT': vectorize_output
  })
#exit QGIS session
qgs.exitQgis()
'''
#read in raster mask shapefile, for clipping the year's nino34.xlsx index array
with fiona.open(vectorize_output, "r") as shapefile:
    vectorize_output_shp = [feature["geometry"] for feature in shapefile]

#https://geohackweek.github.io/raster/04-workingwithrasters/
for file in ppt_file_list:
    base = os.path.basename(file)
    year = base[23:27]

    width = 1405
    height = 621
    with rasterio.open(file) as src:
        thumbnail = src.read(1, out_shape=(1, int(height), int(width)))

        #https://rasterio.readthedocs.io/en/latest/topics/writing.html
        #save resized bil to tif
        tif = ".tif"
        rsz_bil = cwd + '/data/ppt_bil2tif_resize/ppt_bil2tif_resize_'
        output_bil_path2tif = rsz_bil + year + tif
        with rasterio.Env():
            profile = src.profile
            profile.update(
                dtype=rasterio.int32,
                count=1,
                compress='lzw',
                height=621,
                width=1405,
                crs=4269,)
            with rasterio.open(output_bil_path2tif, 'w', **profile,) as dst:
                dst.write(thumbnail.astype(rasterio.int32), 1)
                print(dst.shape)
                print(dst.crs)
    #create a np mask of the year's nino34.xlsx index and save as tif file
    df.loc[df['Year'] == int(year), 'Index']
    yer_index = df.loc[df['Year'] == int(year), 'Index'].iloc[0]
    np_mask = (621,1405)
    yi_array = np.full(np_mask,yer_index)
    #https://gis.stackexchange.com/questions/37238/writing-numpy-array-to-raster-file
    #write array with gdal
    cor_mask_dst_filename = cwd + '/data/ppt_cor_mask/ppt_cor_mask_'
    tif = ".tif"

    dst_filename = cor_mask_dst_filename + year + tif
    x_pixels = 1405  # number of pixels in x
    y_pixels = 621  # number of pixels in y
    driver = gdal.GetDriverByName('GTiff')
    dataset = driver.Create(dst_filename,x_pixels, y_pixels, 1,gdal.GDT_Float32)
    dataset.GetRasterBand(1).WriteArray(yi_array)
    # following code is adding GeoTranform and Projection
    geotrans=data0.GetGeoTransform()  #get GeoTranform from existed 'data0'
    #proj=data0.GetProjection() #you can get from a exsited tif or import 
    dataset.SetGeoTransform(geotrans)
    srs = osr.SpatialReference()
    srs.SetWellKnownGeogCS('NAD83')
    dataset.SetProjection(srs.ExportToWkt())
    dataset.FlushCache()
    band=dataset.GetRasterBand(1)
    band.SetNoDataValue(-9999)
    band=None
    dataset=None

    #read in dst_filename AKA a raster mask from index and clip it with the vectorize_output_shp from qgis
    with rasterio.open(dst_filename) as src:
        out_image, out_transform = rasterio.mask.mask(src, vectorize_output_shp, crop=True)
        out_meta = src.meta
    out_meta.update({"driver": "GTiff",
                     "height": 621,
                     "width": 1405,
                     "transform": out_transform,
                     "crs": "NAD83"})
    #save and clip raster index mask as file
    pearson_staging = cwd + "/data/ppt_pearson_output/ppt_pearson_output_"
    pearson_output_path = pearson_staging + year + tif
    with rasterio.open(pearson_output_path, "w", **out_meta) as dest:
        dest.write(out_image)
    #load clip raster index as a file with rasterio
    #with rasterio.open(pearson_output_path) as src:
    #    pearson_output_path_rasterio = src.read(1, out_shape=(1, int(src.height), int(src.width)))
print("ppt_cor.py is complete")
