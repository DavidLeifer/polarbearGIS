# PolarbearGIS
pipeline for GIS climate raster data </br>

### TLDR
Overall goal is to have it down to a single bash script that </br> automatically installs the R, python, and npm li/braries, downloads </br> the data from Prism, does analysis with python, creates four npm web </br> applications that display climate and weather data. </br>

(Eventual) USAGE</br>
clone directory structure from git</br>
git clone https://github.com/DavidLeifer/polarbearGIS.git</br>
cd polarbearGIS</br>
chmod u+x pipeline.sh</br>
./pipeline.sh</br>

# Progress as of 03/12/2021:

## Step 1: Download Data With R: Complete
Runs 10 R scripts to download data from Oregon St Prism to tmean and ppt folders in the data directory. </br>
This is 33 years of ppt and tmean across the US, 1981-2014. </br>
Why 10 scripts? We're using the unofficial Prism download API, official one </br>
didn't exist in early 2019 when I wrote it.</br>
First bash script runs up to here.</br>

## Step 2: Run Analysis with Python
### Section 1: Complete
</br>
Run ppt_cor.py to output a directory of .tifs that contain raster shapes of elnino.xlsx for each year: /data/ppt_pearson_output/ppt_pearson_output_ </br>
Also saves bils as tif here: /data/ppt_bil2tif_resize/ppt_bil2tif_resize_ </br>
Use those two outputs from ppt_cor.py and input them into ppt_cor_actually.py which runs a moving pearson correlation of 2 columns by 3 rows over index raster </br>
tif and ppt raster tif. Outputs to /data/ppt_pearson_final/ppt_pearson_final_ </br>
Run ppt_tif2XYZ.py (has to use QGIS processing li/brary "import processing", AKA in QGIS python development) which creates XYZ tiles for each correlation </br>
year. Use that as input to section1 of the web application. </br>
TODO: Figure out how to run QGIS libs outside of QGIS (might be QGIS install, try</br> new stable v 3.16) OR firgure out how to use GDAL to style/convert tiffs to XYZ </br>tilefiles so I don't have to compile QGIS on linux in the cloud.</br>

### Section 2: Complete
</br>
Run ppt_bil2tif_LaElNeu_analysis.py to output average ppt and tmean for all the years grouped by elnino, la nina, and neutral winter index (/data/nino34.xlsx) </br> output to: </br>
/data/pptJanELNin/pptJanELNin.tif </br>
/data/pptJanLANin/pptJanLANin.tif </br>
/data/pptJanNeutral/pptJanNeutral.tif </br>
/data/tmeanJanELNin/tmeanJanELNin.tif </br>
/data/tmeanJanLANin/tmeanJanLANin.tif </br>
/data/tmeanJanNeutral/tmeanJanNeutral.tif </br>
These are converted to XYZ tiles and displayed in Section 2 of the web application (with explanation). </br>


### Section 3: Complete
Run both ppt_ANOVA_analysis.py and tmean_ANOVA_analysis.py to output ANOVA values in /data/ppt_ANOVA_output.txt and /data/tmean_ANOVA_output.txt. </br>
TODO: Not sure where to display these tbh</br>

### Section 4: Completed
Create npm OL radar data web application set between Jan 28th and Feb 7th 2019 (maybe play with the speed setting) Status: Complete </br>
Collect twitter data on the Polar Vortex in Jan 2019. Status: Complete </br>
2 year old thesis script Part 1: pull profile location data for all the tweets using tweepy (old script used a hack) Status: Complete </br>
2 year old thesis script Part 2: Geocode named location using Open Street Map Nominatim. Status: Complete </br>
2 year old thesis script Part 3: Sentiment analysis on tweets. Status: Complete. </br>
Combine into one file. Select the points by using a shapefile of the right half of the US. Status: Complete </br>
Group points into increments of 15 minutes (created_at field), select a splice of time and save as geojson. Status: Complete </br>
Make a time-aware OL layer in JS and link it with the radar imagery. Status: Complete </br>


## Step 3: Web Appliction
### Landing Page: Basic html resizeable columns with pics as links to the three pages as described below.
Basically this: https://css-tricks.com/creating-a-modal-image-gallery-with-bootstrap-components/ </br>
### Page 1: Moving Pearson Correlation Tmean
</br>Use Step 2 Section 1 XYZ tiles and use as input to OpenLayers/npm/node/bundler web app that allows you to click through the years.
### Page 2: Moving Pearson Correlation PPT
</br>Use Step 2 Section 1 XYZ tiles and use as input to OpenLayers/npm/node/bundler web app that allows you to click through the years. </br>
### Page 3: ppt and tmean 33 year mean XYZ tiles for el nino, la nina, neutral winters (from part 2, section 2) results in six xyz tiles
### Page 4: Sentiment Analysis of people's opinion during a storm along side the path of the storm


