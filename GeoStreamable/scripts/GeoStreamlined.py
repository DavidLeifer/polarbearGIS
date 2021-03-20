import json, os
import pandas as pd
from glob import glob
import geocoder

import time
import datetime

from collections import Counter
import numpy as np
import unicodedata

from nltk.corpus import stopwords
from nltk.corpus import subjectivity
from nltk.sentiment import SentimentAnalyzer
from nltk.sentiment.util import *
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import tweepy

'''
import nltk
import ssl

try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

nltk.download('stopwords')
nltk.download('vader_lexicon')

'''
# assign the values accordingly 
#https://www.geeksforgeeks.org/python-tweepy-getting-the-location-of-a-user/
'''consumer_key = "xxx" 
consumer_secret = "xxx" 
access_token = "xxx" 
access_token_secret = "xxx" 

#for Anaconda python2.7:
#source activate py27
#data has to be in same dir as the file

#path to the current dir
#all_files to the dir of txt files
# Tweets are stored in in file "fname". In the file used for this script, 
# each tweet was stored on one line
#fname = 'data2/energy20180322T083452.txt'
path = ''
all_files = glob(os.path.join(path, "*.txt"))

#loop through the all_files dir
for fname in all_files:
    df = pd.read_json(fname, lines=True)
    print(df['user'].head())
    name = [d.get('name') for d in df.user]
    id_from_user = [d.get('id') for d in df.user]
    df['name'] = name
    df['id_from_user'] = id_from_user
    #print(df['id_from_user'].head())
    #print(df['user'].head())
    # authorization of consumer key and consumer secret 
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret) 
    auth.set_access_token(access_token, access_token_secret) 
    api = tweepy.API(auth, wait_on_rate_limit=True)    
    loc_hodling = []
    for i in df['id_from_user']:
        try:
            # fetching the user
            user = api.get_user(i) 
            # fetching the location 
            location = user.location 
            print("The location of the user is : " + location)
            loc_hodling.append(location)
        except:
            loc_hodling.append("nan")
            pass
    print(loc_hodling)
    df['location'] = loc_hodling

    df.to_json(fname + '_geo_named.json')
    '''


#create a glob list of the json files in our dir
path = ''
all_files = glob(os.path.join(path, "*.json"))
#loop through the glob list of json files
for data in all_files:
    tweets1 = pd.read_json(data, lines=False)
    #tweets = pd.read_json((df['data']).to_json(), orient='index')
    #tweets1 = pd.read_json((tweets['features']).to_json(), orient='index')
    tweets1['coord'] = 'coord'
    print(tweets1['location'])

    #geocode based on location column
    for index, row in tweets1.iterrows():
        try:
            print(row['location'])
            time.sleep(1.01)
            g = geocoder.osm(row['location'])
            geo = g.latlng
            print(geo)
            tweets1.at[index, 'coord'] = geo
        except:
            pass

    #split the coord column in y and x columns
    #tweets1['coord'] = pd.Series(coord)
    tweets1['coord'] = tweets1['coord'].astype(str)
    tweets1['coord'] = tweets1['coord'].str.strip('[]')
    tweets1['y'], tweets1['x'] = tweets1['coord'].str.split(',', 1).str
    
    #save to a json file
    #tweets1.to_json(data + '_geo.json')
    print("Geocoded " + data)
    
    #sidestep an error reading a string
    tweets1 = tweets1[tweets1['text'].notnull()]
    
    #remove stopwords
    stop = stopwords.words('english')
    tweets1['tweet_without_stopwords'] = tweets1['text'].apply(lambda x: ' '.join([word for word in x.split() if word not in (stop)]))
    stop =  ['The','RT','&amp;', '-', 'A', 'https:', '.', '2']
    tweets1['tweet_without_stopwords'] = tweets1['tweet_without_stopwords'].apply(lambda x: ' '.join([word for word in x.split() if word not in (stop)]))
    #remove periods
    tweets1['tweet_without_stopwords'] = tweets1['tweet_without_stopwords'].str.replace('[\.]','')
    #remove commas
    tweets1['tweet_without_stopwords'] = tweets1['tweet_without_stopwords'].str.replace('[\,]','')
    #remove -
    tweets1['tweet_without_stopwords'] = tweets1['tweet_without_stopwords'].str.replace('[-]','')
    #remove @
    tweets1['tweet_without_stopwords'] = tweets1['tweet_without_stopwords'].str.replace('[@]','')
    
    #sentiment analysis using VADER
    tweets1["compound"] = ''
    tweets1["neg"] = ''
    tweets1["neu"] = ''
    tweets1["pos"] = ''
    sid = SentimentIntensityAnalyzer()
    
    compound_list = []
    neg_list = []
    neu_list = []
    pos_list = []
    for user, row in tweets1.T.iteritems():
        try:
            sentence = unicodedata.normalize('NFKD', tweets1.loc[user, 'tweet_without_stopwords'])
            ss = sid.polarity_scores(sentence)
            compound_row = ss['compound']
            compound_list.append(compound_row)
            print(compound_row)
            
            neg_row = ss['neg']
            neg_list.append(neg_row)

            neu_row = ss['neu']
            neu_list.append(neu_row)

            pos_row = ss['pos']
            pos_list.append(pos_row)

            #print(tweets1['compound'])
            #tweets1.at(user, 'neg') = ss['neg']
            #tweets1.at(user, 'neu') = ss['neu']
            #tweets1.at(user, 'pos') = ss['pos']
        except:
            compound_list.append("nan")
            neg_list.append("nan")
            neu_list.append("nan")
            pos_list.append("nan")

            print(tweets1.loc[user, 'tweet_without_stopwords'])
    tweets1["compound"] = compound_list
    tweets1["neg"] = neg_list
    tweets1["neu"] = neu_list
    tweets1["pos"] = pos_list
    #print a positive message and save the file
    print("Sentiment analyzed " + data)
    tweets1.to_json(data + '_geo_sent.json')


