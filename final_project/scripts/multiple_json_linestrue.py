import os, json
import pandas as pd
from glob import glob

#https://stackoverflow.com/questions/20906474/import-multiple-csv-files-into-pandas-and-concatenate-into-one-dataframe
path = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data'
all_files = glob(os.path.join(path, "*.json"))
df_from_each_file = (pd.read_json(f, lines=False) for f in all_files)
df = pd.concat(df_from_each_file)

print(df)

filename = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_geocoded.csv'

df.to_csv(filename, index=False, encoding='utf-8')

import geopandas as gpd
from geopandas import GeoDataFrame
from shapely.geometry import Point
import fiona
import matplotlib.pyplot as plt

#csv as geopandas AKA gdf
df = pd.read_csv('/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_geocoded.csv')
df['x'] = pd.to_numeric(df['x'],errors='coerce')
df['y'] = pd.to_numeric(df['y'],errors='coerce')
geometry = [Point(xy) for xy in zip(df.x, df.y)]
crs = ("epsg:4326")
df = df.drop(['x', 'y'], axis=1)
geo_df = GeoDataFrame(df, crs=crs, geometry=geometry)
gdf = geo_df.to_crs("epsg:4269")
pr = gdf.crs
print(pr)

# Read vector data in as GeoDataFrame AKA poly
poly1 = gpd.read_file("/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/EastCoast.shp")
poly = poly1.loc[poly1['NAME'] == "Kentucky"]
pr = poly.crs
print(pr)

#tweets2 = gdf.within(poly)
#mask = gdf[gdf.geometry.within(poly)]
intersect = gpd.sjoin(gdf, poly, how='inner', op='within', lsuffix='left', rsuffix='right')
intersect.plot()
plt.show()

#filename = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_filtered.csv'
#tweets2.to_csv(filename, index=False, encoding='utf-8')

