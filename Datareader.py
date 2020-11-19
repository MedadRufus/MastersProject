#!/usr/bin/env python
# coding: utf-8

# In[9]:


import glob
import pandas as pd
import os
import matplotlib.pyplot as plt


# In[19]:


path = r'D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data'                     # use your path
all_files = glob.glob(os.path.join(path, "*.csv"))     # advisable to use os.path.join as this makes concatenation OS independent

df_from_each_file = (pd.read_csv(f,sep= ";") for f in all_files)
concatenated_df   = pd.concat(df_from_each_file, ignore_index=True)
# doesn't create a list, nor does it append to one

concatenated_df.tail(1000)


# In[15]:


concatenated_df.count()


# In[17]:


concatenated_df.describe()


# In[10]:


concatenated_df.plot(x="YYYY-MO-DD HH-MI-SS_SSS", y=["ACCELEROMETER X (m/s²)","ACCELEROMETER Y (m/s²)","ACCELEROMETER Z (m/s²)"])
#plt.show()


# In[20]:


concatenated_df.plot(y="LOCATION Latitude : ", x="LOCATION Longitude : ")


# In[22]:


unique_df = concatenated_df.drop_duplicates(subset=['LOCATION Latitude : ', 'LOCATION Longitude : '], keep='last')


# In[23]:


#unique_df.to_csv(r"D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data\combined.csv")


# In[2]:


import pandas as pd

import plotly.express as px

fig = px.scatter_mapbox(unique_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="LOCATION Speed ( Kmh)")
fig.update_layout(mapbox_style="open-street-map")
fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
fig.show()

