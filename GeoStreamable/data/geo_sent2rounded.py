import os, json
import pandas as pd
from glob import glob
import geopandas as gpd
from geopandas import GeoDataFrame
from shapely.geometry import Point
import fiona
import matplotlib.pyplot as plt
import datetime as dt

#df = pd.read_json('/Users/davidleifer/Documents/20170101-20190604/Geog531/GeoStreamable/data/energy20190204T160315.txt_geo_named.json_geo_sent.json', lines=False)
#for i, row in df.iterrows():
#    print(row)
# Read vector data in as GeoDataFrame AKA poly, use this to select points in polygon in the for loop
poly1 = gpd.read_file("/Users/davidleifer/Documents/20170101-20190604/Geog531/GeoStreamable/data/EastCoast.shp")
poly = poly1.loc[poly1['NAME'] == "Kentucky"]
#https://stackoverflow.com/questions/20906474/import-multiple-csv-files-into-pandas-and-concatenate-into-one-dataframe
path = '/Users/davidleifer/Documents/20170101-20190604/Geog531/GeoStreamable/data'
all_files = glob(os.path.join(path, "*geo_sent.json"))
#loop over glob list of files
for i in all_files:
    df = pd.read_json(i, lines=False)
    df['x'] = pd.to_numeric(df['x'],errors='coerce')
    df['y'] = pd.to_numeric(df['y'],errors='coerce')
    #create geometry from x and y
    geometry = [Point(xy) for xy in zip(df.x, df.y)]
    crs = ("epsg:4326")
    df = df.drop(['x', 'y'], axis=1)
    geo_df = GeoDataFrame(df, crs=crs, geometry=geometry)
    gdf = geo_df.to_crs("epsg:4269")
    #perform intersect
    intersect = gpd.sjoin(gdf, poly, how='inner', op='within', lsuffix='left', rsuffix='right')
    #make intersect created_at column to_datetime and round to 15 min increment
    intersect['created_at'] = pd.to_datetime(intersect['created_at'])
    intersect['created_at_round'] = intersect['created_at'].dt.round('15min')
    intersect = intersect.to_crs("epsg:4326")
    intersect = intersect.sort_values(by=['created_at_round'], ascending=True)
    intersect['created_at_round'] = pd.to_datetime(intersect['created_at_round'])
    #group intersect by created_at_round AKA every 15 minutes
    grouped = intersect.groupby(intersect['created_at_round'])
    for index, group in grouped:
        group = group.drop(['AWATER', 'ALAND', 'LSAD', 'ALAND', 'AWATER', 'STATEFP', 
                           'STATENS', 'AFFGEOID', 'GEOID', 'STUSPS', 'NAME', 'extended_tweet',
                           'retweeted_status', 'display_text_range', 'extended_entities', 'name',
                           'lang', 'filter_level', 'entities', 'quoted_status_permalink', 'quoted_status',
                           'place', 'coordinates', 'geo', 'user', 'in_reply_to_screen_name'], axis=1)
        group.to_file(str(index) + ".geojson", driver="GeoJSON")

#save as CSV file
#filename = '/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data/polarVortex_intersect_rounded.csv'
#intersect.to_csv(filename, index=False, encoding='utf-8')






