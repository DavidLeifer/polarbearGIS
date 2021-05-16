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
sudo apt install python3-pip
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt install sqlite3

#gdal install stuff
sudo apt-get install libgdal-dev
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

#make some folders to store the data
cd data
sudo mkdir ppt
sudo mkdir tmean
sudo mkdir pptJanELNin
sudo mkdir pptJanLANin
sudo mkdir pptJanNeutral
sudo mkdir tmeanJanELNin
sudo mkdir tmeanJanLANin
sudo mkdir tmeanJanNeutral
sudo mkdir tmean_pearson_final
sudo mkdir ppt_pearson_final
cd ..

#set up the paths
DATA_PATH=$(pwd)
export VARIABLENAME=$DATA_PATH

#set up tmean R script paths
SCRIPT_PATH_PLUS_TMEAN="$VARIABLENAME/scripts/rscripts_tmean/download_prism_data.R"
#set up ppt R script paths
SCRIPT_PATH_PLUS_PPT="$VARIABLENAME/scripts/rscripts_ppt/download_prism_data.R"

#run the download scripts
sudo Rscript $SCRIPT_PATH_PLUS_TMEAN
echo downloaded tmean data
sudo Rscript $SCRIPT_PATH_PLUS1_PPT
echo downloaded ppt data


#Compile QGIS from Source
sudo apt install gnupg software-properties-common
wget -qO - https://qgis.org/downloads/qgis-2020.gpg.key | sudo gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import
sudo chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
sudo add-apt-repository "deb https://qgis.org/ubuntu $(lsb_release -c -s) main"
sudo apt install qgis qgis-plugin-grass

#reveals path for QGIS python
#import sys
#print(sys.executable)

#install the python libraries to QGIS
#QGIS_PYTHON_PATH="/usr/bin/python3"
sudo pip3 install rasterio
sudo pip3 install pandas
sudo pip3 install seaborn
sudo pip3 install guppy3
sudo pip3 install --upgrade pip
sudo pip3 install pyproj
sudo pip3 install fiona

#sudo pip3 install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

# install proj-7
cd ..
wget https://download.osgeo.org/proj/proj-7.2.0.tar.gz
tar xvzf proj-7.2.0.tar.gz
cd proj-7.2.0
sudo ./configure --without-curl
sudo make && sudo make install
PROJ_PATH=$(pwd)
# Download GDAL v3.3.0
cd ..
sudo wget download.osgeo.org/gdal/3.3.0/gdal330.zip
sudo unzip gdal330.zip
cd gdal-3.3.0
sudo ./configure --with-proj=/usr/local
sudo make clean && sudo make && sudo make install

# Set LD_LIBRARY_PATH so that recompiled GDAL is used
export LD_LIBRARY_PATH=/usr/local/lib

## Check if it works
gdalinfo --version

#make path variables to python scripts
PATH_PLUS_PPT_LaElNeu="$VARIABLENAME/scripts/python/ppt_bil2tif_LaElNeu_analysis.py"
PATH_PLUS_TMEAN_LaElNeu="$VARIABLENAME/scripts/python/tmean_bil2tif_LaElNeu_analysis.py"
PATH_PLUS_PPT_ANOVA="$VARIABLENAME/scripts/python/ppt_ANOVA_analysis.py"
PATH_PLUS_TMEAN_ANOVA="$VARIABLENAME/scripts/python/tmean_ANOVA_analysis.py"
PPT_COR="$VARIABLENAME/scripts/python/ppt_cor.py"
TMEAN_COR="$VARIABLENAME/scripts/python/tmean_cor.py"
PPT_COR_ACTUALLY="$VARIABLENAME/scripts/python/ppt_cor_actually.py"
TMEAN_COR_ACTUALLY="$VARIABLENAME/scripts/python/tmean_cor_actually.py"

#Run the python scripts
sudo python3 $PATH_PLUS_PPT_LaElNeu
sudo python3 $PATH_PLUS_TMEAN_LaElNeu
sudo python3 $PATH_PLUS_PPT_ANOVA
sudo python3 $PATH_PLUS_TMEAN_ANOVA
sudo python3 $PPT_COR
sudo python3 $TMEAN_COR

#open the gates!
sudo apt-get install apache2 -y
sudo a2ensite default-ssl
sudo a2enmod ssl
sudo vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
sudo echo "Page served from: $vm_hostname" | \
tee /var/www/html/index.html

#generate TMS tiles
sudo mkdir /var/www/html/tmeanJanELNin
sudo gdal2tiles.py --zoom=2-8 /home/davleifer/polarbearGIS/data/tmeanJanELNin/tmeanJanELNin.tif /var/www/html/tmeanJanELNin

http://35.222.214.226:8080





