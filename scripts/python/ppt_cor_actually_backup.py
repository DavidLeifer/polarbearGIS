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

for example_tif, index_tif in zip(ppt_bil2tif_resize_list,ppt_pearson_output_list):
    base = os.path.basename(example_tif)
    year = base[19:23]
    base2 = os.path.basename(index_tif)
    #load in precipitation raster tif, output from ppt_cor.py located in /data/ppt_bil2tif_resize/
    width = 1405
    height = 621
    with rasterio.open(example_tif, mode="r+") as src:
        ppt_raster = src.read(1, out_shape=(1, int(height), int(width)))
    #load in 1981 index mask raster tif, output from ppt_cor.py located in /data/ppt_pearson_output/
    width = 1405
    height = 621
    with rasterio.open(index_tif) as src:
        index_raster = src.read(1, out_shape=(1, int(height), int(width)))
    print(index_raster.shape)
    print(index_raster.dtype)
    #create one big ol list of the two numppy arrays
    ppt_raster_list = np.concatenate(ppt_raster).ravel().tolist()
    index_raster_list = np.concatenate(index_raster).ravel().tolist()
    df1 = pd.DataFrame(ppt_raster_list)
    df2 = pd.DataFrame(index_raster_list)
    #rolling correlation pandas (4Row by 2 Columns)
    rolling_corr1 = df1.rolling(4).corr(df2)
    rolling_corr1_lst = rolling_corr1.values.tolist()
    npa = np.asarray(rolling_corr1_lst, dtype=np.float32)
    #reshape
    newarr = npa.reshape(621, 1405)
    newarr2 = np.nan_to_num(x=newarr,nan=-9999,posinf=.00001,neginf=-.00001)
    newarr2[newarr2 == .00001] = -9999
    newarr2[newarr2 == -.00001] = -9999
    newarr2[newarr2 == 0] = -9999
    newarr2[newarr2 == 1] = -9999
    newarr2[newarr2 == -1] = -9999

    #reshaped_flat_list_nan2num = np.nan_to_num(reshaped_flat_list)
    with rasterio.open(example_tif) as src:
        naip_data = src.read()
        naip_meta = src.profile
    # make any necessary changes to raster properties, e.g.:
    naip_meta['dtype'] = "float32"
    naip_meta['nodata'] = -9999
    data_dir = "/data/ppt_pearson_final/ppt_pearson_final_"
    dst_filename = cwd + data_dir + year + ".tif"

    with rasterio.open(dst_filename, 'w', **naip_meta) as dst:
        dst.write(newarr2, 1)

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
