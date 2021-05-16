#!/bin/bash

echo begin

#install the correct libraries
sudo apt update
sudo apt-get install wget
sudo apt install git
sudo apt install dirmngr apt-transport-https ca-certificates software-properties-common gnupg2
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian buster-cran35/'
sudo apt install r-base
sudo apt install build-essential
sudo apt-get install libcurl4-openssl-dev libssl-dev


#run R and install the packages, might as well makes this its own R script
R
install.packages("prism")
quit()

#make some folders to store the data
sudo mkdir data
cd data
sudo mkdir ppt
sudo mkdir tmean
cd tmean
cd ..
cd ..

#set up the paths
DATA_PATH=$(pwd)
export VARIABLENAME=$DATA_PATH

#set up tmean R script paths
SCRIPT_PATH_PLUS1_TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data.R"
#set up ppt R script paths
SCRIPT_PATH_PLUS_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data.R"

#run the download scripts
Rscript $SCRIPT_PATH_PLUS_PPT
echo downloaded tmean data
Rscript $SCRIPT_PATH_PLUS1_PPT
echo downloaded ppt data


#TODO Compile QGIS from Dave Source with edited HTML output from
#
#
#

#reveals path for QGIS python
#import sys
#print(sys.executable)

#install the python libraries to QGIS
QGIS_PYTHON_PATH="/Applications/QGIS3.10.app/Contents/MacOS/bin/python3"
$QGIS_PYTHON_PATH -m pip install rasterio
$QGIS_PYTHON_PATH -m pip install numpy
$QGIS_PYTHON_PATH -m pip install pandas
$QGIS_PYTHON_PATH -m pip install pyproj
$QGIS_PYTHON_PATH -m pip install seaborn
$QGIS_PYTHON_PATH -m pip install scipy
$QGIS_PYTHON_PATH -m pip install guppy3

#QT PATH
export QT_QPA_PLATFORM_PLUGIN_PATH=/Applications/QGIS3.10.app/Contents/PlugIns

#make path variables to python scripts
PATH_PLUS_PPT_LaElNeu="$SCRIPT_PATH/scripts/python/ppt_bil2tif_LaElNeu_analysis.py"
PATH_PLUS_TMEAN_LaElNeu="$SCRIPT_PATH/scripts/python/tmean_bil2tif_LaElNeu_analysis.py"
PATH_PLUS_PPT_ANOVA="$SCRIPT_PATH/scripts/python/ppt_ANOVA_analysis.py"
PATH_PLUS_TMEAN_ANOVA="$SCRIPT_PATH/scripts/python/tmean_ANOVA_analysis.py"
TIF2XYZ="$SCRIPT_PATH/scripts/python/tif2XYZ.py"
PPT_COR="$SCRIPT_PATH/scripts/python/ppt_cor.py"
TMEAN_COR="$SCRIPT_PATH/scripts/python/tmean_cor.py"

#Run the python scripts
$QGIS_PYTHON_PATH $PATH_PLUS_PPT_LaElNeu
$QGIS_PYTHON_PATH $PATH_PLUS_TMEAN_LaElNeu
$QGIS_PYTHON_PATH $PATH_PLUS_PPT_ANOVA
$QGIS_PYTHON_PATH $PATH_PLUS_TMEAN_ANOVA
$QGIS_PYTHON_PATH $PPT_COR
$QGIS_PYTHON_PATH $TMEAN_COR
$QGIS_PYTHON_PATH $TIF2XYZ







