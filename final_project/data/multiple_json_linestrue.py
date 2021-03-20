import os, json
import pandas as pd
from glob import glob

#https://stackoverflow.com/questions/20906474/import-multiple-csv-files-into-pandas-and-concatenate-into-one-dataframe
'''path = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data'
all_files = glob(os.path.join(path, "*.json"))
df_from_each_file = (pd.read_json(f, lines=False) for f in all_files)
df = pd.concat(df_from_each_file)

print(df)

filename = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_geocoded.csv'

df.to_csv(filename, index=False, encoding='utf-8')'''

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

#perform intersect
intersect = gpd.sjoin(gdf, poly, how='inner', op='within', lsuffix='left', rsuffix='right')

#make intersect created_at column to_datetime and round to 15 min increment
intersect['created_at'] = pd.to_datetime(intersect['created_at'])
intersect['created_at_round'] = intersect['created_at'].dt.round('15min')
intersect = intersect.to_crs("epsg:4326")
pr = intersect.crs
print(pr)

#save as a GeoJSON file
intersect.to_file("/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_intersect_rounded.geojson", driver="GeoJSON")

df = gpd.read_file('/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_intersect_rounded.geojson')
df = df.sort_values(by=['created_at_round'], ascending=True)
df['created_at_round'] = pd.to_datetime(df['created_at_round'])  
#print(df)
#print(df.dtypes)


start_date = '2019-01-29 18:30:00'
end_date = '2019-01-29 22:30:00'
mask = (df['created_at_round'] > start_date) & (df['created_at_round'] <= end_date)
df = df.loc[mask]
print(df)
#save as a GeoJSON file
df.to_file("/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_rounded_small.geojson", driver="GeoJSON")

#save as CSV file
#filename = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_intersect_rounded.csv'
#intersect.to_csv(filename, index=False, encoding='utf-8')
#intersect_ranged.plot()
#plt.show()


