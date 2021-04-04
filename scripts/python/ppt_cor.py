import rasterio
from rasterio.mask import mask
import rasterio.features
from rasterio.transform import from_origin
from rasterio.warp import calculate_default_transform, reproject, Resampling
import fiona
from shapely.geometry import shape
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

import os
import sys

#os.environ["PROJ_LIB"]="/Applications/QGIS.app/Contents/Resources/proj"

#get current working dir
cwd = os.getcwd()
#read in index
df = pd.read_excel(cwd + '/data/nino34.xlsx', sheet_name='Sheet1')
ppt_data_dir = cwd + '/data/ppt/'
ppt_file_list = glob(os.path.join(ppt_data_dir, '*.bil'))

#transform is used 2 times
transform = from_origin(-125.020833333, 49.937500000, 0.0416666666666,0.0416666666666)

#shapefile is geographic
vectorize_output = cwd + "/data/timeseries_contour_dissolve.shp"

#https://geohackweek.github.io/raster/04-workingwithrasters/
for file in ppt_file_list:
    base = os.path.basename(file)
    year = base[23:27]

    #save resized bil to tif
    width = 1405
    height = 621
    tif = ".tif"
    rsz_bil = cwd + '/data/ppt_bil2tif_resize/ppt_bil2tif_resize_'
    output_bil_path2tif = rsz_bil + year + tif
    with rasterio.open(file) as src:
        kwargs = src.meta.copy()
        kwargs.update({
            #+no_defs +towgs84=0,0,0
            'crs': '+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83 ',
            'transform': transform,
            'width': width,
            'height': height
        })
        with rasterio.open(output_bil_path2tif, 'w', **kwargs) as dst:
            for i in range(1, src.count + 1):
                reproject(
                    source = rasterio.band(src, i),
                    destination = rasterio.band(dst, i),
                    src_transform = src.transform,
                    src_crs = src.crs,
                    dst_transform = transform,
                    dst_crs = '+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83',
                    resampling = Resampling.nearest)
        print(dst.crs)

    with rasterio.Env():
        #create a np mask of the year's nino34.xlsx index and save as tif file
        df.loc[df['Year'] == int(year), 'Index']
        yer_index = df.loc[df['Year'] == int(year), 'Index'].iloc[0]
        np_mask = (621,1405)
        yi_array = np.full(np_mask,yer_index)
        #write array with rasterio
        cor_mask_dst_filename = cwd + '/data/ppt_cor_mask/ppt_cor_mask_'
        tif = ".tif"
        dst_filename = cor_mask_dst_filename + year + tif

        new_dataset = rasterio.open(dst_filename, 'w', 
                            driver='GTiff',
                            height = height, 
                            width = width,
                            count=1,
                            dtype=str(yi_array.dtype),
                            crs='+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83',
                            transform=transform)

        new_dataset.write(yi_array, 1)
        new_dataset.close()

    #read in raster mask shapefile, for clipping the year's nino34.xlsx index array
    with fiona.open(vectorize_output, "r") as shapefile:
        vectorize_output_shp = [feature["geometry"] for feature in shapefile]
    #read in dst_filename AKA a raster mask from index and clip it with the vectorize_output_shp from qgis

    with rasterio.open(dst_filename) as src:
        out_image, out_transform = mask(src, vectorize_output_shp, crop=True)
        out_meta = src.meta
        print(transform)
        print(out_transform)
    out_meta.update({"driver": "GTiff",
                         "height": 621,
                         "width": 1405,
                         "transform": out_transform,
                         "crs": "+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83"})
    #save and clip raster index mask as file
    pearson_staging = cwd + "/data/ppt_pearson_output/ppt_pearson_output_"
    pearson_output_path = pearson_staging + year + tif
    with rasterio.open(pearson_output_path, "w", **out_meta) as dest:
        dest.write(out_image)
        #print(dest.shape)
        print(dest.crs)
print("ppt_cor.py is complete")

#RESIZE == OGC:CRS84 - WGS 84 (CRS84) - Geographic
#OUTPUT == EPSG:4326 - WGS 84 - Geographic
