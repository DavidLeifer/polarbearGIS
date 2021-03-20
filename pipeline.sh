#!/bin/bash
#!/usr/bin/env Rscript

#clone directory structure from git
#git clone https://github.com/DavidLeifer/pandamoniumGIS.git
#cd pandamoniumGIS

echo begin

#download R packages for linux DONT TEST UNTIL ON LINUX
#sudo apt update
#sudo apt install r-base
#sudo apt build-dep r-base

#set Bash variable for use within R script
cd data
cd ppt
DATA_PATH=$(pwd)
export VARIABLENAME=$DATA_PATH
#return to pandamoniumGIS parent dir
cd ..
cd ..
#set up R script paths
SCRIPT_PATH=$(pwd)
SCRIPT_PATH_PLUS_PPT="$SCRIPT_PATH/scripts/rscripts_ppt/download_prism_data.R"
SCRIPT_PATH_PLUS1_PPT="$SCRIPT_PATH/scripts/rscripts_ppt/download_prism_data1.R"
SCRIPT_PATH_PLUS2_PPT="$SCRIPT_PATH/scripts/rscripts_ppt/download_prism_data2.R"
SCRIPT_PATH_PLUS3_PPT="$SCRIPT_PATH/scripts/rscripts_ppt/download_prism_data3.R"
SCRIPT_PATH_PLUS4__PPT="$SCRIPT_PATH/scripts/rscripts_ppt/download_prism_data4.R"
#run the download scripts
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS1_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS2_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS3_PPT
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS4__PPT
echo downloaded ppt data

#set Bash variable for use within R script
cd data
cd tmean
DATA_PATH2=$(pwd)
export VARIABLENAME2=$DATA_PATH2
#return to pandamoniumGIS parent dir
cd ..
cd ..
#set up R script paths
SCRIPT_PATH=$(pwd)
SCRIPT_PATH_PLUS_TMEAN="$SCRIPT_PATH/scripts/rscripts_tmean/download_prism_data.R"
SCRIPT_PATH_PLUS1_TMEAN="$SCRIPT_PATH/scripts/rscripts_tmean/download_prism_data1.R"
SCRIPT_PATH_PLUS2_TMEAN="$SCRIPT_PATH/scripts/rscripts_tmean/download_prism_data2.R"
SCRIPT_PATH_PLUS3_TMEAN="$SCRIPT_PATH/scripts/rscripts_tmean/download_prism_data3.R"
SCRIPT_PATH_PLUS4_TMEAN="$SCRIPT_PATH/scripts/rscripts_tmean/download_prism_data4.R"
#run the download scripts 
#which Rscript
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS1_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS2_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS3_TMEAN
/usr/local/bin/Rscript $SCRIPT_PATH_PLUS4_TMEAN
echo downloaded tmean data

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







