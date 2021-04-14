# PolarbearGIS
pipeline for GIS climate raster data <br>

USAGE<br>
clone directory structure from git<br>
git clone https://github.com/DavidLeifer/polarbearGIS.git<br>
cd polarbearGIS<br>
chmod u+x pipeline.sh<br>
./pipeline.sh<br>

# Progress as of 01/09/2021:

## Step 1: Download Data With R
Runs 10 R scripts to download data from Oregon St Prism to tmean and ppt folders in the data directory. <br>
This is 33 years of ppt and tmean across the US, 1981-2014. <br>
Why 10 scripts? We're using the unofficial Prism download API, official one <br>
didn't exist in early 2019 when I wrote it.

## Step 2: Run Analysis with Python
### Section 1:
Run ppt_cor.py to output a directory of .tifs that contain raster shapes of elnino.xlsx for each year: /data/ppt_pearson_output/ppt_pearson_output_ <br>
Also saves bils as tif here: /data/ppt_bil2tif_resize/ppt_bil2tif_resize_ <br>
Use those two outputs from ppt_cor.py and input them into ppt_cor_actually.py which runs a moving pearson correlation of 2 columns by 3 rows over index raster <br>
tif and ppt raster tif. Outputs to /data/ppt_pearson_final/ppt_pearson_final_ <br>
Run ppt_tif2XYZ.py (has to use QGIS processing library "import processing", AKA in QGIS python development) which creates XYZ tiles for each correlation <br>
year. Use that as input to section1 of the web application. <br>
TODO: Do the same thing for tmean. <br>
TODO1: Figure out how to run QGIS libs outside of QGIS (might be QGIS install, try new stable v 3.16)

### Section 2:
Run ppt_bil2tif_LaElNeu_analysis.py to output average ppt and tmean for all the years grouped by elnino, la nina, and neutral winter index (/data/nino34.xlsx) <br> output to: <br>
/data/pptJanELNin/pptJanELNin.tif <br>
/data/pptJanLANin/pptJanLANin.tif <br>
/data/pptJanNeutral/pptJanNeutral.tif <br>
/data/tmeanJanELNin/tmeanJanELNin.tif <br>
/data/tmeanJanLANin/tmeanJanLANin.tif <br>
/data/tmeanJanNeutral/tmeanJanNeutral.tif <br>
These will be converted to XYZ tiles and displayed in Section 2 of the web application (with explanation). <br>
TODO: Make almost clone of ppt_tif2XYZ.py <br>
to make XYZ tile directory for both ppt and tmean. <br>

### Section 3:
Run both ppt_ANOVA_analysis.py and tmean_ANOVA_analysis.py to output ANOVA values in /data/ppt_ANOVA_output.txt and /data/tmean_ANOVA_output.txt. <br>
These will be displayed in Section 3 of the web application. <br>

## Step 3: Web Appliction <br>
### Landing Page: Basic html resizeable columns with pics as links to the three pages as described below. <br>
Basically this: https://css-tricks.com/creating-a-modal-image-gallery-with-bootstrap-components/ <br>
### Page 1: Moving Pearson Correlation <br>
Use Step 2 Section 1 XYZ tiles and use as input to OpenLayers/npm/node/bundler web app that allows you to click through the years (ppt and tmean). <br>
### Page 2: ppt and tmean 33 year mean XYZ tiles for el nino, la nina, neutral winters (from part 2, section 2) <br>
### Page 3: Small blurb about the resulting z-scores AKA resutls from part 2 section 3 of analysis. <br>

