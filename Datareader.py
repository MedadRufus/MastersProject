#!/usr/bin/env python
# coding: utf-8

# In[9]:


import glob
import pandas as pd
import os
import matplotlib.pyplot as plt
import numpy as np


# In[19]:


path = r'D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data'                     # use your path
all_files = glob.glob(os.path.join(path, "*.csv"))     # advisable to use os.path.join as this makes concatenation OS independent

df_from_each_file = (pd.read_csv(f,sep= ";") for f in all_files)
concatenated_df   = pd.concat(df_from_each_file, ignore_index=True)
# doesn't create a list, nor does it append to one

# calculate abs accleration
concatenated_df["abs_acceleration"] = np.linalg.norm(concatenated_df[["ACCELEROMETER X (m/s²)","ACCELEROMETER Y (m/s²)","ACCELEROMETER Z (m/s²)"]].values,axis=1)
concatenated_df["abs_loc"] = np.linalg.norm(concatenated_df[['LOCATION Latitude : ', 'LOCATION Longitude : ']].values,axis=1)


concatenated_df.plot(x="YYYY-MO-DD HH-MI-SS_SSS", y=["ACCELEROMETER X (m/s²)","ACCELEROMETER Y (m/s²)","ACCELEROMETER Z (m/s²)"])




# remove all duplicated long lat positions
concatenated_df = concatenated_df.groupby('abs_loc').mean().reset_index()

concatenated_df["gps_acceleration"] = concatenated_df["LOCATION Speed ( Kmh)"].diff()

concatenated_df["power"] = concatenated_df["gps_acceleration"] * concatenated_df["LOCATION Speed ( Kmh)"] * 80


concatenated_df.to_csv(r"D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data\combined.csv")





import plotly.express as px

#fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="LOCATION Speed ( Kmh)")
#fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="abs_acceleration")
#fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="gps_acceleration")
fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="power")

fig.update_layout(mapbox_style="open-street-map")
fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
fig.show()

