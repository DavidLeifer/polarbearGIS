#save as csv

import json, os
import pandas as pd

fname = "/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data_collection/energy20190206T153016.txt_geo_named.json_geo_sent.json"

df = pd.read_json(fname, lines=False)
df.to_csv('/Users/davidleifer/Documents/20170101-20190604/Geog531/final_project/data_collection/energy20190206T153016.txt_geo_named.json_geo_sent.csv')
