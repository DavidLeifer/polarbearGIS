# PolarbearGIS
A pipeline for GIS climate raster data. A script of scripts, using GCP.</br>

### TLDR
Overall goal is to have it down to a single bash script that </br> automatically installs the R, python, and npm libraries, downloads </br> the data from Prism, does analysis with python, creates four npm web </br> applications that display climate and weather data. </br>

### (Eventual) USAGE ON DEBIAN
#### clone directory structure from git</br>
sudo apt update</br>
sudo apt install git</br>
sudo git clone https://github.com/DavidLeifer/polarbearGIS.git</br>
cd polarbearGIS</br>
chmod u+x pipeline.sh</br>
./pipeline.sh</br>

PolarbearGIS is a spatiotemporal data pipeline at the intersection of climatological, computer science, and geospatial technologies. The processing occurs on a Google Cloud Platform Debian instance and is orchestrated by a BASH script, installing libraries required for Python, R, NPM, and compiling GDAL from source to generate XYZ tile files. Data is downloaded through an R script and a module called Prism to examine the El Nino-Southern Oscillation (ENSO), which is said to control precipitation and temperature in the Pacific North West and Southeastern United States. By manipulating such Python libraries as Rasterio, GDAL, Geopandas, SciPy, Numpy, and Seaborn, correlation between the elnino34 index and climate rasters has been achieved for 33 years of data. Analysis of the Variance of the Means (ANOVA) and mean groupings for El Nino, La Nina, and Neutral years are further used to examine spatial patterns. Tweepy, geocoder, and NLTK are also utilized to create geojson files of twitter sentiment to be displayed overlaid radar data of a winter storm event dubbed the Polar Vortex of 2019. NPM installs OpenLayers packages and are choreographed to generate space-time visualizations for display across multiple browsers and platforms.
</br>
Some of the technical details are outlined in my blog, which can be found on my website and was generated using LibreOffice save to HTML function. This is the most FOSS4G I could think of.

# TODO as of 05/29/2021:
-GDAL -v 3.3.0 XYZ Tiles finally work (with color), need to build for the 33 years of prec, temp, and mean groupings</br>
-Need to add a gdrive link to download the json of twitter sentiment so I can run the python scripts to split the data into a geojson file for each 15 minute time stamp to feed into the ol map</br>
-Might add a streamhist function from ye ol farmer’s package, might be overkill tbh</br>
-Have to install npm and build the files, might also be overkill</br>
-Finish GeoStreamable?</br>

# GeoStreamable
------------- </br>
### SCRIPT
1) Get tweets (set CRON job to reset every hour)</br>
2) Sentiment analysis/geocode named places (Set CRON job to run after a json file of tweets is made)</br>
3) Point in polygon and round the data to 15 minute increments and save as a geojson file</br>
### APPLICATION
4) Ingest each file and programmatically add to map</br>
5) Add popup info window to tweet to display text but noo personally identify information from the user (as carefully stipulated in the docs)</br>

Got an angel on my left shoulder, a devil on the polar</br>
Got a mug a frigid, got a mug a solar, slide over

