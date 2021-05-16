import rasterio
from rasterio.mask import mask
from rasterio import Affine
import rasterio.features
from rasterio.transform import from_origin
from rasterio.warp import calculate_default_transform, reproject, Resampling
from rasterio.plot import show
import fiona
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
df = pd.read_csv(cwd + '/data/nino34.csv')
#create list of folders
data_dir = cwd + '/data/tmean/*'
data_dir_list = glob(data_dir)
#create a list of bil paths from each sub folder
folder_bil_list = []
for i in data_dir_list:
    folder_bil = glob(os.path.join(i, '*.bil'))
    str1 = ''.join(folder_bil)
    folder_bil_list.append(str1)

#transform is used 2 times
#transform = from_origin(-125.020833333, 49.937500000, 0.0416666666666,0.0416666666666)

#make the dir to hold the bil data
output_bil_dir = cwd + '/data/tmean_bil2tif_resize/'
os.mkdir(output_bil_dir)
#make the dir to hold the index square data
output_msk_dir = cwd + '/data/tmean_cor_mask/'
os.mkdir(output_msk_dir)
#make the dir to hold the clipped index data
output_clipped_index_dir = cwd + '/data/tmean_pearson_output/'
os.mkdir(output_clipped_index_dir)

#https://geohackweek.github.io/raster/04-workingwithrasters/
for file in folder_bil_list:
    base = os.path.basename(file)
    year = base[25:29]
    print(year)

    #save resized bil to tif
    width = 1405
    height = 621
    tif = ".tif"
    rsz_bil = cwd + '/data/tmean_bil2tif_resize/tmean_bil2tif_resize_'
    output_bil_path2tif = rsz_bil + year + tif

    with rasterio.open(file) as src:
        thumbnail = src.read(1, 
            out_shape=(1, int(height), int(width)))
        print("OG bil = ")
        print(src.crs.wkt)

        with rasterio.Env():
            profile = src.profile
            profile.update(
                dtype=rasterio.int32,
                count=1,
                compress='lzw',
                height=height,
                width=width,
                crs=src.crs,
                transform=src.transform,)
            with rasterio.open(output_bil_path2tif, 'w', **profile,) as dst:
                dst.write(thumbnail.astype(rasterio.int32), 1)
                print("resized tif = ")
                print(dst.crs.wkt)
                dst.close()

    with rasterio.Env():
        #create a np mask of the year's nino34.xlsx index and save as tif file
        df.loc[df['Year'] == int(year), 'Index']
        yer_index = df.loc[df['Year'] == int(year), 'Index'].iloc[0]
        np_mask = (621,1405)
        yi_array = np.full(np_mask,yer_index)
        #write array with rasterio
        cor_mask_dst_filename = cwd + '/data/tmean_cor_mask/tmean_cor_mask_'
        tif = ".tif"
        dst_filename = cor_mask_dst_filename + year + tif

        new_dataset = rasterio.open(dst_filename, 'w', 
                            driver='GTiff',
                            height = height, 
                            width = width,
                            count=1,
                            dtype=str(yi_array.dtype),
                            crs=src.crs,
                            transform=src.transform)

        new_dataset.write(yi_array, 1)
        #print(new_dataset.crs)
        print("square mask = ")
        print(new_dataset.crs.wkt)
        new_dataset.close()

    #read in raster mask shapefile, for clipping the year's nino34.xlsx index array
    vectorize_output_reproj = cwd + "/data/timeseries_contour_dissolve.shp"
    with fiona.open(vectorize_output_reproj, "r") as shapefile_reproj:
        vectorize_output_shp_reproj = [feature["geometry"] for feature in shapefile_reproj]

    #read in dst_filename AKA a raster mask from index and clip it with the vectorize_output_shp from qgis
    with rasterio.open(dst_filename) as foo_fighter:
        out_image, out_transform = mask(foo_fighter, vectorize_output_shp_reproj, crop=False, nodata=-9999)
        out_meta = foo_fighter.meta
    out_meta.update({"driver": "GTiff",
                         "height": height,
                         "width": width,
                         "transform": src.transform,
                         "crs": src.crs,
                         "nodata": -9999})
    #save and clip raster index mask as file
    pearson_staging = cwd + "/data/tmean_pearson_output/tmean_pearson_output_"
    pearson_output_path = pearson_staging + year + tif
    with rasterio.open(pearson_output_path, "w", **out_meta) as foo_fighter_dest:
        foo_fighter_dest.write(out_image)
        print("clipped index = ")
        print(foo_fighter_dest.crs.wkt)
        src.close()
        foo_fighter_dest.close()

print("tmean_cor.py is complete")


