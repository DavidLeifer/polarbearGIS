#/Applications/QGIS-LTR.app/Contents/MacOS/bin/python3.8 -m pip install streamhist
#/Applications/QGIS-LTR.app/Contents/MacOS/bin/python3.8 -m pip install mpld3
#/Applications/QGIS-LTR.app/Contents/MacOS/bin/python3.8 /Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python_weather/Geo_streamhist.py
#/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/polar_radar_unsplit

import numpy as np
import matplotlib.pyplot as plt
plt.style.use("ggplot")  # Makes for nicer looking plots

try:
    from functools import reduce
except ImportError:
    pass

from streamhist import StreamHist
from numpy import histogram, allclose
import pandas as pd
import os
from glob import glob
#from mpld3 import save_html

#gotta add cwd in server version after testing
cwd = os.getcwd()
folders = cwd + "/data/polar_radar_unsplit"
#folders = "/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/data/polar_radar_unsplit"

all_files = glob(os.path.join(folders, "*geo_sent.json"))

#read json, convert 0 to nan, drop nan, append json files to list_of_compound_json, 
numpy_of_compound_json = np.array([])
for json_files in all_files:
    json = pd.read_json(json_files)
    json_comp = json['compound']
    json_naned = json_comp.replace(0.000, np.nan)
    json_no_nan = json_naned.dropna(how='all', axis=0)
    compound_json = json_no_nan.to_numpy()
    numpy_of_compound_json = np.concatenate([numpy_of_compound_json, compound_json])

#create histogram of json
length = numpy_of_compound_json.shape[0]
bins = 25
h9 = StreamHist().update(numpy_of_compound_json)
hist1, bins1 = h9.compute_breaks(bins)
hist2, bins2 = histogram(numpy_of_compound_json, bins=bins)

if allclose(bins1, bins2):
    print("The bin breaks are all close")
if allclose(hist1, hist2, rtol=1, atol=length/(bins**2)):
    print("The bin counts are all close")

width = 0.7 * (bins2[1] - bins2[0])
c1 = [(a + b)/2. for a, b in zip(bins1[:-1], bins1[1:])]
c2 = [(a + b)/2. for a, b in zip(bins2[:-1], bins2[1:])]

plt.figure(figsize=(2, 2))
f, (ax1, ax2) = plt.subplots(1, 2, sharey=False, figsize=(2, 2))
fig = plt.figure()
plt.bar(c1, hist1, align='center', width=width)
plt.title("Computed Sentiment Breaks")
plt.ylabel("Frequency")
plt.xlabel("Data")
plt.savefig(cwd + '/data/Breaks.png')
#plt.savefig('/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python_weather/Breaks.png')
#save_html(fig,"/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python_weather/Breaks.html")

fig2 = plt.figure()
plt.bar(c2, hist2, align='center', width=width)
plt.title("Numpy Sentiment Histogram")
plt.ylabel("Frequency")
plt.xlabel("Data")
plt.savefig(cwd + '/data/Histogram.png')
#plt.savefig('/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python_weather/Histogram.png')
#save_html(fig2,"/Users/davidleifer/Documents/20170101-20190604/Geog531/Assignment2/polarbearGIS/gitLab/polarbearGIS/scripts/python_weather/Histogram.html")


