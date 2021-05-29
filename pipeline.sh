#!/bin/bash
echo begin

#install the correct libraries
sudo apt update
sudo apt-get install wget
sudo apt install git
#install R stuff
sudo apt install dirmngr apt-transport-https ca-certificates software-properties-common gnupg2
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian buster-cran35/'
sudo apt install r-base
sudo apt install build-essential
#install python stuff
sudo apt-get install libcurl4-openssl-dev libssl-dev
sudo apt install python3-pip
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt install sqlite3
#gdal python install stuff
sudo apt-get install python3-gdal

#sudo apt-get install libgdal-dev
#export CPLUS_INCLUDE_PATH=/usr/include/gdal
#export C_INCLUDE_PATH=/usr/include/gdal

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
sudo Rscript $SCRIPT_PATH_PLUS_PPT
echo downloaded ppt data



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

#install proj-7
cd ..
wget https://download.osgeo.org/proj/proj-7.2.0.tar.gz
tar xvzf proj-7.2.0.tar.gz
cd proj-7.2.0
sudo ./configure --without-curl
sudo make && sudo make install
#Download GDAL v3.3.0 from source
cd ..
sudo wget download.osgeo.org/gdal/3.3.0/gdal330.zip
sudo unzip gdal330.zip
cd gdal-3.3.0
sudo ./configure --with-proj=/usr/local --with-python3
sudo make clean && sudo make && sudo make install
# Set LD_LIBRARY_PATH so that recompiled GDAL is used
export LD_LIBRARY_PATH=/usr/local/lib

## Check if it works
gdalinfo --version


#install python bindings?
#cd swig
#cd python
#sudo python3 setup.py build
#sudo python3 setup.py install
#/usr/local/lib/python3.7/dist-packages/GDAL-3.3.0-py3.7-linux-x86_64.egg

sudo pip3 install GDAL==3.3.0

#make path variables to python scripts
#cd ..
#cd ..
cd ..
cd polarbearGIS

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
sudo tee /var/www/html/index.html

# NOTES
# https://blog.mastermaps.com/2012/06/creating-color-relief-and-slope-shading.html
# https://gdal.org/programs/gdal2tiles.html
#make some dirs to hold the xyz tiles
sudo mkdir /var/www/html/ppt_bil2tif_LaElNeu_analysis_xyz/
sudo mkdir /var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz/
sudo mkdir /var/www/html/tmean_cor_xyz/
sudo mkdir /var/www/html/ppt_cor_xyz/
sudo mkdir /var/www/html/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanELNin
sudo mkdir /var/www/html/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanLANin
sudo mkdir /var/www/html/ppt_bil2tif_LaElNeu_analysis_xyz/xyz_pptJanNeutral
sudo mkdir /var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanELNin
sudo mkdir /var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanLANin
sudo mkdir /var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanNeutral
sudo mkdir /var/www/html/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final
sudo mkdir /var/www/html/ppt_cor_xyz/ppt_cor_xyz_ppt_pearson_final

#make the color txt files
sudo nano $VARIABLENAME/data/tmeanJanELNin/color_relief.txt

#make it pretty (and 8bit)
sudo gdaldem color-relief $VARIABLENAME/data/tmeanJanELNin/tmeanJanELNin.tif $VARIABLENAME/data/tmeanJanELNin/color_relief.txt $VARIABLENAME/data/tmeanJanELNin/tmeanJanELNin_color.tif -alpha
#generate TMS tiles
sudo gdal2tiles.py --zoom=2-8 --tilesize=128 $VARIABLENAME/data/tmeanJanELNin/tmeanJanELNin_color.tif /var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanELNin


http://34.122.XXX.XXX/tmean_bil2tif_LaElNeu_analysis_xyz/xyz_tmeanJanELNin/openlayers.html


