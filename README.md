# PolarbearGIS
A pipeline for GIS climate raster data. A script of scripts, using GCP.</br>

### A BASH script that automatically installs the R, python, and npm libraries, downloads the data from Prism, does analysis with python, and creates four npm web applications that display climate and weather data.

+ [Support PolarbearGIS](#support-polarbeargis)
+ [Screenshots](#screenshots)
+ [Usage on Debian](#usage-on-debian)
+ [Summary](#summary)
+ [Features](#features)
+ [Used Libraries](#used-libraries)
+ [TODO](#todo)
+ [GeoStreamable](#geostreamable)
+ [Pol Ivers](#pol-ivers)

### Support PolarbearGIS
* Polarbears are vulnerable!
* Star, fork and watch it on Github.
* Contribute <a href="https://github.com/DavidLeifer/polarbearGIS/issues">bug reports or suggest features</a>
* Translate it into a different language and have </br>
![Fun](/imgs/fun.gif?raw=true)

### Screenshots
1. Temperature Correlated with nino34 Index
![Temp](/polar_landing/images/temp_cor.png)
2. Precipitation Correlated with nino34 Index
![Temp](/polar_landing/images/ppt_cor.png)
3. Mean January Temperature and Precipitation Grouped by Oscillation
![Temp](/polar_landing/images/Part2Section2.png)
4. Twitter Sentiment Alongside Radar of the Polar Vortex 2019 Storm
![Temp](/polar_landing/images/polar_radar.png)

### Usage on Debian
1. Update `sudo apt update`
2. Install Git `sudo apt install git`
3. Clone Repository `sudo git clone https://github.com/DavidLeifer/polarbearGIS.git`
4. `cd polarbearGIS`
5. Make executable `chmod u+x pipeline.sh`
6. Run the program `./pipeline.sh`

### Summary
PolarbearGIS is a spatiotemporal data pipeline at the intersection of climatological, computer science, and geospatial technologies. The processing occurs on a Google Cloud Platform Debian instance and is orchestrated by a BASH script, installing libraries required for Python, R, NPM, and compiling GDAL from source to generate XYZ tile files. Data is downloaded through an R script and a module called Prism to examine the El Nino-Southern Oscillation (ENSO), which is said to control precipitation and temperature in the Pacific North West and Southeastern United States.</br></br>
By manipulating such Python libraries as Rasterio, GDAL, Geopandas, SciPy, Numpy, and Seaborn, correlation between the nino34 index and climate rasters has been achieved for 33 years of data. Analysis of the Variance of the Means (ANOVA) and mean groupings for El Nino, La Nina, and Neutral years are further used to examine spatial and statistical patterns. Tweepy, geocoder, and NLTK are also utilized to create geojson files of twitter sentiment to be displayed overlaid radar data of a winter storm event dubbed the Polar Vortex of 2019. NPM installs OpenLayers packages and are choreographed to generate space-time visualizations for display across multiple browsers and platforms.
</br></br>
Some of the technical details are outlined in my blog, which can be found on my website and were generated using LibreOffice's save to HTML function. This is the most FOSS4G I could think of. </br>

### Features
* Generation of a series of rasters from a csv index
* Correlation between two rasters
* Saving bils as geotifs
* Means of rasters grouped by a csv index
* ANOVA of rasters grouped by a csv index
* Splitting json by date and time and saving as geojson
* Performing point in polygon
* Building map applications
* Automated installation of libraries in the cloud
* Compiling GDAL from source
* HTTP/HTTPS load balancer
* Bears.

### Used Libraries
- Python
  * Rasterio: https://github.com/mapbox/rasterio
  * GDAL: https://github.com/OSGeo/gdal
  * GeoPandas: https://github.com/geopandas/geopandas
  * SciPy: https://github.com/scipy/scipy
  * NumPy: https://github.com/numpy/numpy
  * SeaBorn: https://github.com/mwaskom/seaborn
- R
  * Prism: https://github.com/ropensci/prism
- JavaScript
  * NPM: https://github.com/npm/cli
  * OpenLayers: https://github.com/openlayers/openlayers
  * ParcelBundler: https://github.com/parcel-bundler/parcel
  * OpenLayers-Ext: https://github.com/Viglino/ol-ext
- BASH
  * WGET: https://savannah.gnu.org/git/?group=wget
  * Git: https://github.com/git/git
  * R: https://www.r-project.org/
  * Build-Essential: https://packages.debian.org/sid/build-essential
  * LibCurl4: https://packages.debian.org/jessie/libcurl4-openssl-dev
  * Libssl-dev: https://packages.debian.org/jessie/libssl-dev
  * Pip: https://github.com/pypa/pip
  * Sqlite: https://github.com/sqlite/sqlite
  * GDAL: https://gdal.org/download.html

### TODO 
05/29/2021:</br>
- GDAL -v 3.3.0 XYZ Tiles work (with color), need to build for the 33 years of prec, temp, and mean groupings: https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script</br>
- Need to add a gdrive link to download the json of twitter sentiment so I can run the python scripts to split the data into a geojson file for each 15 minute time stamp to feed into the ol map</br>
- Might add a streamhist function from ye ol farmer’s package to polar vortex, might be overkill tbh</br>
- Have to install npm and build the web files, might also be overkill</br>
- Finish GeoStreamable?</br>

### GeoStreamable
- SCRIPT
1. Get tweets (set CRON job to reset every hour)
2. Sentiment analysis/geocode named places (Set CRON job to run after a json file of tweets is made)
3. Streamhist: https://github.com/carsonfarmer/streamhist
4. Point in polygon and round the data to 15 minute increments and save as a geojson file
- APPLICATION
5. Ingest each file and programmatically add to map
6. Add popup info window to tweet to display text but noo personally identifiable information from the user (as carefully stipulated in the docs)

### Pol Ivers
Got an angel on my left shoulder, a devil on the polar</br>
Got a mug a frigid, got a mug a solar, sliiiide over</br>

![Pol Ivers](/imgs/pol-ivers.png?raw=true)
