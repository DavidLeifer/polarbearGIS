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
#input_raster_folder = '/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/ppt_pearson_final(backup)'
input_raster_folder_list = glob(os.path.join(input_raster_folder, '*.tif'))
input_raster_folder_list.sort()

for input_raster in input_raster_folder_list:

    # open the dataset and retrieve raster data as an array
    dataset = gdal.Open(input_raster)
    band = dataset.GetRasterBand(1)
    array = band.ReadAsArray()

    nodata_val = band.GetNoDataValue()
    if nodata_val is not None:
        array = np.ma.masked_equal(array, nodata_val)

    array_ignored_nan = array[array >= array.min()]

    # create an array of zeros the same shape as the input array
    output = np.zeros_like(array).astype(np.uint8)

    # use the numpy percentile function to calculate percentile thresholds, gotta round for scientific notation
    percentile_80 = round(np.percentile(array_ignored_nan, 80), 5)
    percentile_60 = round(np.percentile(array_ignored_nan, 60), 5)
    percentile_40 = round(np.percentile(array_ignored_nan, 40), 5)
    percentile_20 = round(np.percentile(array_ignored_nan, 20), 5)
    percentile_0 = round(np.percentile(array_ignored_nan, 0), 5)

    print(percentile_0, percentile_20, percentile_40, percentile_60, percentile_80)
    
    txt_outname = os.path.splitext(input_raster)[0] + "_reclassed.txt"
    print(txt_outname)

    with open(txt_outname, "w") as text_file:
        text_file.write(str(percentile_0) + " " + str(percentile_20) + " " + str(percentile_40) + " " + str(percentile_60) + " " + str(percentile_80))
            
    output = np.where((array > percentile_0), 1, output)
    output = np.where((array > percentile_20), 2, output)
    output = np.where((array > percentile_40), 3, output)
    output = np.where((array > percentile_60), 4, output)
    output = np.where((array > percentile_80), 5, output)

    outname = os.path.splitext(input_raster)[0] + "_reclassed.tif"
    gdal_array.SaveArray(output, outname, "gtiff", prototype=dataset)

    print(outname)
print("quantile_reclassify.py complete")

