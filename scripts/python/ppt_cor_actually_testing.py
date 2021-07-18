import rasterio
import pandas as pd
import numpy as np
from scipy.stats.stats import pearsonr
import shutil
from rasterio.plot import show
from osgeo import ogr, gdal, osr
from osgeo.gdalnumeric import *
from osgeo.gdalconst import *
import os
from glob import glob

#avoid annoying PROJ_LIB error
#os.environ["PROJ_LIB"]="/Applications/QGIS.app/Contents/Resources/proj"

#/Applications/QGIS-LTR.app/Contents/MacOS/bin/python3 /Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python/ppt_cor_actually.py
#/Applications/QGIS-LTR.app/Contents/MacOS/bin/pip3 install pandas==1.2.5

#get current working dir
cwd = os.getcwd()
#read in ppt_bil2tif_resize as list of file directories
ppt_bil2tif_resize = cwd + '/data/ppt_bil2tif_resize/'
ppt_bil2tif_resize_list = glob(os.path.join(ppt_bil2tif_resize, '*.tif'))
ppt_bil2tif_resize_list.sort()
#print(ppt_bil2tif_resize_list)

#read in index files as list of file directories
ppt_pearson_output = cwd + '/data/ppt_pearson_output/'
ppt_pearson_output_list = glob(os.path.join(ppt_pearson_output, '*.tif'))
ppt_pearson_output_list.sort()
#print(ppt_pearson_output_list)

#https://stackoverflow.com/questions/66615107/how-to-tackle-inconsistent-results-while-using-pandas-rolling-correlation

for example_tif, index_tif in zip(ppt_bil2tif_resize_list,ppt_pearson_output_list):
    base = os.path.basename(example_tif)
    year = base[19:23]
    base2 = os.path.basename(index_tif)

    #read in ppt raster
    dataset = gdal.Open(example_tif)
    band = dataset.GetRasterBand(1)
    array = band.ReadAsArray()
    nodata_val = band.GetNoDataValue()
    if nodata_val is not None:
        array = np.ma.masked_equal(array, nodata_val)
    ppt_raster = array[array >= array.min()]
    # create an array of zeros the same shape as the input array
    output = np.zeros_like(array).astype(np.float32)

    #read in index raster
    dataset2 = gdal.Open(index_tif)
    band2 = dataset2.GetRasterBand(1)
    array2 = band2.ReadAsArray()
    nodata_val2 = band2.GetNoDataValue()
    if nodata_val is not None:
        array2 = np.ma.masked_equal(array2, nodata_val2)
    index_raster = array2[array2 >= array2.min()]

    df1 = pd.DataFrame(
        {'elnino': index_raster,
         'ppt': ppt_raster
        })
    df1 = pd.Series(index_raster)
    df2 = pd.Series(ppt_raster)

    rolling_corr = df1.rolling(10).corr(df2)
    for i in rolling_corr:
        print(i)

    #make rolling_corr a list
    rolling_corr_list = rolling_corr.tolist()
    for i in (rolling_corr_list):
        print(i)
    #convert list into numyp array
    rolling_corr_array = np.array(rolling_corr_list)
    #convert first few nans in -9999
    rolling_corr_array = np.nan_to_num(rolling_corr_array, nan=-9999, posinf=-9999, neginf=-9999)

    #put back in 0s aka no data
    output[output == 0] = rolling_corr_array
    output[output == -9999] = 0

    #reshaped_flat_list_nan2num = np.nan_to_num(reshaped_flat_list)
    with rasterio.open(example_tif) as src:
        naip_data = src.read()
        naip_meta = src.profile
    # make any necessary changes to raster properties, e.g.:
    naip_meta['dtype'] = "float32"
    naip_meta['nodata'] = 0
    data_dir = "/data/ppt_pearson_final/ppt_pearson_final_"
    dst_filename = cwd + data_dir + year + ".tif"

    with rasterio.open(dst_filename, 'w', **naip_meta) as dst:
        dst.write(output, 1)
    print(year + " correlated")

print("Finished ppt_cor_actually.py")

'''
#read tif back in and show it
pearsonr_test = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/pearsonr_test.tif"
pearsonr_test_interpolated = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/panda_testing/pandamoniumGIS/data/pearsonr_test_interpolated.tif"

width = 1405
height = 621
with rasterio.open(pearsonr_test, mode="r+") as src:
    pearsonr_test_var = src.read(1, out_shape=(1, int(height), int(width)))
    msk = src.read_masks()
    new_msk = (msk[0])
    from rasterio.features import sieve
    from rasterio.fill import fillnodata
    sieved_msk = sieve(new_msk, size=420)
    interpolation = fillnodata(pearsonr_test_var, sieved_msk, max_search_distance=4.20, smoothing_iterations=0)
#write as interpolated tif
with rasterio.open(pearsonr_test_interpolated, 'w', **naip_meta) as dst:
    dst.write(interpolation, 1)
show(interpolation)  
#show(np.dstack(msk))
#show(pearsonr_test_var)
'''
