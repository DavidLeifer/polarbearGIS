import numpy as np
from osgeo import gdal, gdal_array
import subprocess
import os
from glob import glob

#shamelessly stolen from:
#https://gis.stackexchange.com/questions/229796/reclassify-a-raster-file-with-quantiles
#/Applications/QGIS-LTR.app/Contents/MacOS/bin/python3 /Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python/quantile_reclassify.py
#https://numpy.org/doc/stable/reference/generated/numpy.nanquantile.html#numpy.nanquantile

cwd = os.getcwd()
input_raster_folder = cwd + '/data/ppt_pearson_final/'
#input_raster_folder = '/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_pearson_final'
input_raster_folder_list = glob(os.path.join(input_raster_folder, '*.tif'))
input_raster_folder_list.sort()

for input_raster in input_raster_folder_list:

    # open the dataset and retrieve raster data as an array
    dataset = gdal.Open(input_raster)
    band = dataset.GetRasterBand(1)
    array = band.ReadAsArray()

    # create an array of zeros the same shape as the input array
    output = np.zeros_like(array).astype(np.float32)

    # use the numpy percentile function to calculate percentile thresholds
    percentile_80 = np.nanquantile(array, .99, interpolation="nearest", keepdims=True)
    percentile_60 = np.nanquantile(array, .75, interpolation="nearest", keepdims=True)
    percentile_40 = np.nanquantile(array, .5, interpolation="nearest", keepdims=True)
    percentile_20 = np.nanquantile(array, .25, interpolation="nearest", keepdims=True)
    percentile_0 = np.nanquantile(array, .001, interpolation="nearest", keepdims=True)

    print(percentile_80)
    print(percentile_60)
    print(percentile_40)
    print(percentile_20)
    print(percentile_0)

    output = np.where((array > percentile_0), 0, output)
    #print("output percentile_0 = " + str(output))
    output = np.where((array > percentile_20), 1, output)
    #print("output percentile_20 = " + str(output))
    output = np.where((array > percentile_40), 2, output)
    #print("output percentile_40 = " + str(output))
    output = np.where((array > percentile_60), 3, output)
    #print("output percentile_60 = " + str(output))
    output = np.where((array > percentile_80), 4, output)
    #print("output percentile_80 = " + str(output))

    outname = os.path.splitext(input_raster)[0] + "_reclassed.tif"
    gdal_array.SaveArray(output, outname, "gtiff", prototype=dataset)
    print(outname)
print("quantile_reclassify.py complete")

