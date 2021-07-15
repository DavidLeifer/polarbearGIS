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
+ [Polar Bears](#polar-bears)

### Support PolarbearGIS
* Polarbears are vulnerable!
* Star and fork it on GitLab
* Contribute bug reports or suggest features
* Translate it into a different language

### Screenshots
1. Temperature Correlated with nino34 Index
[![Temp](/polar_landing/images/temp_cor.png)](https://www.davidjleifer.com/pandamoniumGIS20210110_tmeanbuild/index.html)
2. Precipitation Correlated with nino34 Index
[![Temp](/polar_landing/images/ppt_cor.png)](https://www.davidjleifer.com/polarbearGIS/index.html)
3. Mean January Temperature and Precipitation Grouped by Oscillation
[![Temp](/polar_landing/images/Part2Section2.png)](https://www.davidjleifer.com/pandamoniumGIS_part2Section2_build-dist/index.html)
4. Difference between El Nino and Neutral years and La Nina and Neutral years
[![Temp](/polar_landing/images/difference-image.png)](https://www.davidjleifer.com/tha_difference-dist/index.html)
5. Twitter Sentiment Alongside Radar of the Polar Vortex 2019 Storm
[![Temp](/polar_landing/images/polar_radar.png)](https://www.davidjleifer.com/polar_radar/index.html)

### Usage on Debian
1. Update `sudo apt update`
2. Install Git `sudo apt install git`
3. Clone Repository `sudo git clone https://gitlab.com/davleifer/polarbearGIS.git`
4. `cd polarbearGIS`
5. Make executable `chmod u+x pipeline.sh`
6. Run the program `./pipeline.sh`

### Summary
PolarbearGIS is a simple data pipeline at the intersection of climatological, computer science, and geospatial technologies. The processing occurs on a Google Cloud Platform Debian instance and is orchestrated by a BASH script, installing libraries required for Python, R, NPM, and compiling GDAL from source to generate XYZ tile files. Data is downloaded through an R script and a module called Prism to examine the El Nino-Southern Oscillation (ENSO), which is said to control precipitation and temperature in the Pacific North West and Southeastern United States.




By manipulating such Python libraries as Rasterio, GDAL, Geopandas, SciPy, Numpy, and Seaborn, correlation between the nino34 index and climate rasters has been achieved for 33 years of data. Analysis of the Variance of the Means (ANOVA) and mean groupings for El Nino, La Nina, and Neutral years are further used to examine spatial and statistical patterns. Tweepy, geocoder, and NLTK are also utilized to create geojson files of twitter sentiment to be displayed overlaid radar data of a winter storm event dubbed the Polar Vortex of 2019. NPM installs OpenLayers packages and are choreographed to generate space-time visualizations for display across multiple browsers and platforms.




Some of the technical details are outlined in my blog, which can be found on my website and were generated using LibreOffice's save to HTML function. This is the most FOSS4G I could think of.

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
  * StreamHist: https://github.com/carsonfarmer/streamhist
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
07/14/2021:</br>
- ~~Make slider work on mobile. Difficulty: Easy~~
- Getting different ppt/nino34 cor values on debian as opposed to mac. Some of the values are the same, some are not. Think its how linux represents small numbers: https://stackoverflow.com/questions/6913532/display-a-decimal-in-scientific-notation Difficulty: Hard
- Add logic to change year and slider position based on drop down input. https://jqueryui.com/slider/#hotelrooms Difficulty: Medium
- Correlation between co2 and temp/ppt, would probably have to average yearly values and co2 ppm: https://www.co2.earth/historical-co2-datasets Difficulty: Medium?
- Refactor code into OOP so it is more reusable. Difficulty: Hard
- Finish GeoStreamable? Difficulty: Hard

### GeoStreamable
- SCRIPT
1. Get tweets (set CRON job to reset every hour)
2. Sentiment analysis/geocode named places (Set CRON job to run after a json file of tweets is made)
3. Streamhist: https://github.com/carsonfarmer/streamhist
4. Point in polygon and round the data to 15 minute increments and save as a geojson file
- APPLICATION
5. Ingest each file and programmatically add to map
6. Add popup info window to display tweet text but noo personally identifiable information from the user (as carefully stipulated in the docs)

### Polar Bears
![Polar Bears](/imgs/polar-bears.png?raw=true)




