#!/bin/bash
echo begin

#install the correct libraries
sudo apt-get update
#sudo apt-get upgrade
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
#install geopandas stuf
sudo apt install libspatialindex-dev
#install node and npm
sudo apt install nodejs npm

#install node stuff with npm
sudo npm install ol
sudo npm install -g parcel-bundler
sudo npm install ol-ext
#sudo npm install http-proxy --save
#sudo npm uninstall http-proxy-rules --save

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

sudo mkdir ppt_elnino_minus_neutral
sudo mkdir ppt_lanina_minus_neutral
sudo mkdir tmean_elnino_minus_neutral
sudo mkdir tmean_lanina_minus_neutral
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

#install python libraries with pip3
sudo pip3 install rasterio
sudo pip3 install pandas
sudo pip3 install seaborn
sudo pip3 install guppy3
sudo pip3 install --upgrade pip
sudo pip3 install pyproj
sudo pip3 install fiona
sudo pip3 install geopandas
sudo pip3 install rtree

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
sudo ./configure --with-proj=/usr/local
sudo make clean && sudo make && sudo make install
# Set LD_LIBRARY_PATH so that recompiled GDAL is used
export LD_LIBRARY_PATH=/usr/local/lib

## Check if it works
#gdalinfo --version

#return to ~/polarbearGIS/data/
cd ..
cd polarbearGIS
cd data

#download polar_radar_unsplit.zip data
#https://drive.google.com/file/d/1hN8TKgep0bBL2x0NtkEX666Ge-WMLASZ/view?usp=sharing
sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1hN8TKgep0bBL2x0NtkEX666Ge-WMLASZ' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1hN8TKgep0bBL2x0NtkEX666Ge-WMLASZ" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt
sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data
cd ..

#make path variables to python scripts
PATH_PLUS_PPT_LaElNeu="$VARIABLENAME/scripts/python/ppt_bil2tif_LaElNeu_analysis.py"
PATH_PLUS_TMEAN_LaElNeu="$VARIABLENAME/scripts/python/tmean_bil2tif_LaElNeu_analysis.py"
#PATH_PLUS_PPT_ANOVA="$VARIABLENAME/scripts/python/ppt_ANOVA_analysis.py"
#PATH_PLUS_TMEAN_ANOVA="$VARIABLENAME/scripts/python/tmean_ANOVA_analysis.py"
PPT_COR="$VARIABLENAME/scripts/python/ppt_cor.py"
TMEAN_COR="$VARIABLENAME/scripts/python/tmean_cor.py"
PPT_COR_ACTUALLY="$VARIABLENAME/scripts/python/ppt_cor_actually.py"
TMEAN_COR_ACTUALLY="$VARIABLENAME/scripts/python/tmean_cor_actually.py"
GEOSENT_2ROUNDED="$VARIABLENAME/scripts/python_weather/geosent_2rounded.py"
TMEAN_LAELNEU_DIFF="$VARIABLENAME/scripts/python/tmean_LaElNeu_diff.py"
PPT_LAELNEU_DIFF="$VARIABLENAME/scripts/python/ppt_LaElNeu_diff.py"

#Run the python scripts
sudo python3 $PATH_PLUS_PPT_LaElNeu
sudo python3 $PATH_PLUS_TMEAN_LaElNeu
sudo python3 $PATH_PLUS_PPT_ANOVA
sudo python3 $PATH_PLUS_TMEAN_ANOVA
sudo python3 $PPT_COR
sudo python3 $TMEAN_COR
sudo python3 $PPT_COR_ACTUALLY
sudo python3 $TMEAN_COR_ACTUALLY
sudo python3 $GEOSENT_2ROUNDED
sudo python3 $TMEAN_LAELNEU_DIFF
sudo python3 $PPT_LAELNEU_DIFF

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

#copy over the ANOVA files onto web server
sudo cp ~/polarbearGIS/data/tmean_ANOVA_output.txt /var/www/html
sudo cp ~/polarbearGIS/data/ppt_ANOVA_output.txt /var/www/html

#copy over the sentiment histogram html files output from streamhist
sudo cp ~/polarbearGIS/data/Histogram.png /var/www/html
sudo cp ~/polarbearGIS/data/Breaks.png /var/www/html

#Declare a tmean_grouping_array of string with type
declare -a tmean_grouping_array=(
	"$VARIABLENAME/data/tmeanJanELNin/tmeanJanELNin.tif" 
	"$VARIABLENAME/data/tmeanJanLANin/tmeanJanLANin.tif" 
	"$VARIABLENAME/data/tmeanJanNeutral/tmeanJanNeutral.tif" )

#Declare a tmean_grouping_array_color
declare -a tmean_grouping_array_color=(
	"$VARIABLENAME/data/tmeanJanELNin/tmeanJanELNin_color.tif" 
	"$VARIABLENAME/data/tmeanJanLANin/tmeanJanLANin_color.tif" 
	"$VARIABLENAME/data/tmeanJanNeutral/tmeanJanNeutral_color.tif" )

#Declare a tmean_grouping_array_xyz
TMEAN_BIL2TIF_LAELNEU_ANALYSIS_XYZ="/var/www/html/tmean_bil2tif_LaElNeu_analysis_xyz"
declare -a tmean_grouping_array_xyz=(
	"$TMEAN_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_tmeanJanELNin" 
	"$TMEAN_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_tmeanJanLANin" 
	"$TMEAN_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_tmeanJanNeutral" )

#tmean_color_relief
TMEAN_COLOR_RELIEF=$VARIABLENAME/data/tmean_color_relief.txt

#Iterate all tmean_grouping_array*
for index in ${!tmean_grouping_array[*]};
do
	 #make pretty colors
	 sudo gdaldem color-relief ${tmean_grouping_array[$index]} $TMEAN_COLOR_RELIEF ${tmean_grouping_array_color[$index]} -alpha
    #build xyz tiles
    sudo gdal2tiles.py --zoom=2-8 --tilesize=128 ${tmean_grouping_array_color[$index]} ${tmean_grouping_array_xyz[$index]}
done

#Declare a ppt_grouping_array of string with type
declare -a ppt_grouping_array=(
	"$VARIABLENAME/data/pptJanELNin/pptJanELNin.tif" 
	"$VARIABLENAME/data/pptJanLANin/pptJanLANin.tif" 
	"$VARIABLENAME/data/pptJanNeutral/pptJanNeutral.tif" )

#Declare a ppt_grouping_array_color
declare -a ppt_grouping_array_color=(
	"$VARIABLENAME/data/pptJanELNin/pptJanELNin_color.tif" 
	"$VARIABLENAME/data/pptJanLANin/pptJanLANin_color.tif" 
	"$VARIABLENAME/data/pptJanNeutral/pptJanNeutral_color.tif" )

#Declare a tmean_grouping_array_xyz
PPT_BIL2TIF_LAELNEU_ANALYSIS_XYZ="/var/www/html/ppt_bil2tif_LaElNeu_analysis_xyz"
declare -a ppt_grouping_array_xyz=(
	"$PPT_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_pptJanELNin" 
	"$PPT_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_pptJanLANin" 
	"$PPT_BIL2TIF_LAELNEU_ANALYSIS_XYZ/xyz_pptJanNeutral" )

#ppt_color_relief
PPT_COLOR_RELIEF=$VARIABLENAME/data/ppt_color_relief.txt

#Iterate all ppt_grouping_array*
for index_2 in ${!ppt_grouping_array[*]};
do
	 #make pretty colors
	 sudo gdaldem color-relief ${ppt_grouping_array[$index_2]} $PPT_COLOR_RELIEF ${ppt_grouping_array_color[$index_2]} -alpha
    #build xyz tiles
    sudo gdal2tiles.py --zoom=2-8 --tilesize=128 ${ppt_grouping_array_color[$index_2]} ${ppt_grouping_array_xyz[$index_2]}
done

#Declare a PPT_DIFF of string with type
declare -a PPT_DIFF=(
	"$VARIABLENAME/data/ppt_elnino_minus_neutral/ppt_elnino_minus_neutral.tif" 
	"$VARIABLENAME/data/ppt_lanina_minus_neutral/ppt_lanina_minus_neutral.tif" )

#Declare a PPT_DIFF_COLOR output
declare -a PPT_DIFF_COLOR=(
	"$VARIABLENAME/data/ppt_elnino_minus_neutral/ppt_elnino_minus_neutral_color.tif" 
	"$VARIABLENAME/data/ppt_lanina_minus_neutral/ppt_lanina_minus_neutral_color.tif" )

#Declare a array of ppt xyz diff output
VAR_WWW_HTML="/var/www/html"
declare -a PPT_DIFF_ARRAY_XYZ=(
	"$VAR_WWW_HTML/ppt_elnino_minus_neutral_xyz" 
	"$VAR_WWW_HTML/ppt_lanina_minus_neutral_xyz" )

#PPT_DIFF_COLOR_RELIEF
PPT_DIFF_COLOR_RELIEF=$VARIABLENAME/data/ppt_diff_color_relief.txt

#Iterate all PPT_DIFF*
for index in ${!PPT_DIFF[*]};
do
	 #make pretty colors
	 sudo gdaldem color-relief ${PPT_DIFF[$index]} $PPT_DIFF_COLOR_RELIEF ${PPT_DIFF_COLOR[$index]} -alpha
    #build xyz tiles
    sudo gdal2tiles.py --zoom=2-8 --tilesize=128 ${PPT_DIFF_COLOR[$index]} ${PPT_DIFF_ARRAY_XYZ[$index]}
done

#Declare a TMEAN_DIFF of string with type
declare -a TMEAN_DIFF=(
	"$VARIABLENAME/data/tmean_elnino_minus_neutral/tmean_elnino_minus_neutral.tif" 
	"$VARIABLENAME/data/tmean_lanina_minus_neutral/tmean_lanina_minus_neutral.tif" )

#Declare a TMEAN_DIFF_COLOR output
declare -a TMEAN_DIFF_COLOR=(
	"$VARIABLENAME/data/tmean_elnino_minus_neutral/tmean_elnino_minus_neutral_color.tif" 
	"$VARIABLENAME/data/tmean_lanina_minus_neutral/tmean_lanina_minus_neutral_color.tif" )

#Declare a array of tmean xyz diff output
VAR_WWW_HTML="/var/www/html"
declare -a TMEAN_DIFF_ARRAY_XYZ=(
	"$VAR_WWW_HTML/tmean_elnino_minus_neutral_xyz" 
	"$VAR_WWW_HTML/tmean_lanina_minus_neutral_xyz" )

#TMEAN_DIFF_COLOR_RELIEF
TMEAN_DIFF_COLOR_RELIEF=$VARIABLENAME/data/tmean_diff_color_relief.txt

#Iterate all TMEAN_DIFF*
for index in ${!TMEAN_DIFF[*]};
do
	 #make pretty colors
	 sudo gdaldem color-relief ${TMEAN_DIFF[$index]} $TMEAN_DIFF_COLOR_RELIEF ${TMEAN_DIFF_COLOR[$index]} -alpha
    #build xyz tiles
    sudo gdal2tiles.py --zoom=2-8 --tilesize=128 ${TMEAN_DIFF_COLOR[$index]} ${TMEAN_DIFF_ARRAY_XYZ[$index]}
done

#make ppt_pearson_final variable
ppt_pearson_final="$VARIABLENAME/data/ppt_pearson_final"
#ppt_pearson_final_color
PPT_PEARSON_FINAL_COLOR=$VARIABLENAME/data/ppt_pearson_final_color.txt
COLOR="_color.tif"
#PPT_COR_XYZ_BASE folders for xyz tiles
PPT_COR_XYZ_BASE="/var/www/html/ppt_cor_xyz/ppt_cor_xyz_ppt_pearson_final_"

increment=1981
#loop over ppt_pearson_final, concat _color.tif to the output, build xyz tiles
for ppt_index in "$ppt_pearson_final"/*.tif
do
	 #make ppt_index_color_output concat the base of ppt_index with COLOR for color output
	 ppt_index_color_output=${ppt_index%%.*}$COLOR
    #make PPT_COR_XYZ_OUTPUT concat PPT_COR_XYZ_BASE with the year for xyz tile output folder
	 PPT_COR_XYZ_OUTPUT=$PPT_COR_XYZ_BASE$increment
	 sudo gdaldem color-relief $ppt_index $PPT_PEARSON_FINAL_COLOR $ppt_index_color_output -alpha
	 echo "Color tif for year "$increment
	 sudo gdal2tiles.py --zoom=2-8 --tilesize=128 $ppt_index_color_output $PPT_COR_XYZ_OUTPUT
	 echo "xyz tiles for year"$increment
    increment=$((increment+1))
    if [[ $increment -eq 2015 ]];
    then
       break
    fi
done

#make tmean_pearson_final variable
tmean_pearson_final="$VARIABLENAME/data/tmean_pearson_final"
#tmean_pearson_final_color
TMEAN_PEARSON_FINAL_COLOR=$VARIABLENAME/data/tmean_pearson_final_color.txt
COLOR="_color.tif"
#TMEAN_COR_XYZ_BASE folders for xyz tiles
TMEAN_COR_XYZ_BASE="/var/www/html/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_"

#one caveat in tmean cor is that the 0 values are being set to transparent in the tmean_pearson_final_color.txt
#this differs from ppt cor, where 0 values are set to -9999 in the python script
#then -9999 is set to transparent in ppt_pearson_final_color.txt
#hope this makes sense future dave!
increment=1981
#loop over tmean_pearson_final, concat _color.tif to the output, build xyz tiles
for tmean_index in "$tmean_pearson_final"/*.tif
do
	 #make tmean_index_color_output concat the base of tmean_index with COLOR for color output
	 tmean_index_color_output=${tmean_index%%.*}$COLOR
    #make TMEAN_COR_XYZ_OUTPUT concat TMEAN_COR_XYZ_BASE with the year for xyz tile output folder
	 TMEAN_COR_XYZ_OUTPUT=$TMEAN_COR_XYZ_BASE$increment
	 sudo gdaldem color-relief $tmean_index $TMEAN_PEARSON_FINAL_COLOR $tmean_index_color_output -alpha
	 echo "Color tif for year "$increment
	 sudo gdal2tiles.py --zoom=2-8 --tilesize=128 $tmean_index_color_output $TMEAN_COR_XYZ_OUTPUT
	 echo "xyz tiles for year"$increment
    increment=$((increment+1))
    if [[ $increment -eq 2015 ]];
    then
       break
    fi
done

#sudo rm /home/davleifer/polarbearGIS/data/tmean_pearson_final/*_color.tif
#sudo rm -R /var/www/html/tmean_cor_xyz/
#sudo mkdir /var/www/html/tmean_cor_xyz/

http://XX.XX.xxx.XX/tmean_cor_xyz/tmean_cor_xyz_tmean_pearson_final_1981/openlayers.html

###################
#build node applications with npm
cd pandamoniumGIS20210110_tmeanbuild
sudo npm run-script build
cd ..
cd pandamoniumGIS_part2Section2_build
sudo npm run-script build
cd ..
cd polarbear
sudo npm run-script build
cd ..
cd tha_difference
sudo npm run-script build
cd ..
cd polar_radar
sudo npm run-script build
cd ..

#move the newly created files to their web home
sudo mv ~/polarbearGIS/pandamoniumGIS20210110_tmeanbuild/dist /var/www/html/pandamoniumGIS20210110_tmeanbuild
sudo mv ~/polarbearGIS/pandamoniumGIS_part2Section2_build/dist /var/www/html/pandamoniumGIS_part2Section2_build-dist
sudo mv ~/polarbearGIS/polarbear/dist /var/www/html/polarbearGIS
sudo mv ~/polarbearGIS/tha_difference/dist /var/www/html/tha_difference-dist
sudo mv ~/polarbearGIS/polar_radar/dist /var/www/html/polar_radar

