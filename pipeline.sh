#!/bin/bash

echo begin

#install the correct libraries
sudo apt update
sudo apt-get install wget
sudo apt install build-essential
sudo apt install gfortran
sudo apt install zlib1g zlib1g-dev
sudo apt-get install liblzma-dev
sudo apt install pcre2-utils
sudo apt-get install libpcre++-dev
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install default-jdk
sudo apt-get install texlive-full
#remove unneeded stuff from texlive
sudo rm -R /usr/share/texlive/texmf-dist/fonts
sudo rm -R /usr/share/texlive/texmf-dist/doc
#back to downloading libs
sudo apt-get clean; sudo apt-get autoclean
sudo apt-get install dpkg
sudo dpkg --configure -a
#sudo apt --fix-broken install
sudo apt-get clean; sudo apt-get autoclean
sudo apt install libgeos-dev
sudo apt install libudunits2-dev
sudo apt install libgdal-dev
sudo apt-get install libbz2-dev

cd ..

#install R on Debian compile from source and install some libs
sudo wget https://cran.rstudio.com/src/base/R-4/R-4.0.4.tar.gz
sudo tar -xf R-4.0.4.tar.gz
cd R-4.0.4
sudo ./configure --with-readline=no --with-x=no --with-pcre1
sudo make
#let them eat cake
cd doc
sudo sudo touch NEWS.2.rds NEWS.3.rds
cd ..
sudo make install
#run R and install the packages, might as well makes this its own R script
R
install.packages("rgeos")
yes
yes
75
install.packages("spatialEco", INSTALL_opts = '--no-lock')
install.packages("RCurl")
quit()
n
#return to polarbearGIS dir
cd ..
cd polarbearGIS
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
SCRIPT_PATH_PLUS1_TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data1.R"
SCRIPT_PATH_PLUS2_TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data2.R"
SCRIPT_PATH_PLUS3_TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data3.R"
SCRIPT_PATH_PLUS4__TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data4.R"
#set up ppt R script paths
SCRIPT_PATH_PLUS_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data.R"
SCRIPT_PATH_PLUS1_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data1.R"
SCRIPT_PATH_PLUS2_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data2.R"
SCRIPT_PATH_PLUS3_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data3.R"
SCRIPT_PATH_PLUS4__PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data4.R"

#run the download scripts
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS1_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS2_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS3_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS4__TMEAN
echo downloaded tmean data
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS1_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS2_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS3_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS4__PPT
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







