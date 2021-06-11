import rasterio
from rasterio.plot import show

#read tif back in and show it
pearsonr_test = "/home/davleifer/polarbearGIS/data/ppt_pearson_final/ppt_pearson_final_1981.tif"

width = 1405
height = 621
with rasterio.open(pearsonr_test, mode="r+") as src:
    pearsonr_test_var = src.read(1, out_shape=(1, int(height), int(width)))

show(pearsonr_test_var)

for i in pearsonr_test_var:
	for ii in i:
		print(ii)