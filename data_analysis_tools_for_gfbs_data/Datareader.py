#!/usr/bin/env python
# coding: utf-8
#######################################################################
# How to setup AndroSensor:
# Install AndroSensor
# Ensure when installing, allow app to run in background.
# Open settings and change recording interval to fast.
#
#
#
#######################################################################


import glob
import os

import numpy as np
import pandas as pd
import plotly.express as px

# IF useing ; sep, then delete the first line.
path = r'D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data'  # use your path
all_files = glob.glob(
    os.path.join(path, "*.csv"))  # advisable to use os.path.join as this makes concatenation OS independent

df_from_each_file = [pd.read_csv(f, sep=";") for f in all_files]
concatenated_df = pd.concat(df_from_each_file, ignore_index=True)
concatenated_df["YYYY-MO-DD HH-MI-SS_SSS"] = pd.to_datetime(concatenated_df["YYYY-MO-DD HH-MI-SS_SSS"],format='%Y-%m-%d %H:%M:%S:%f')

concatenated_df.rename(columns={'YYYY-MO-DD HH-MI-SS_SSS': 'date_time'}, inplace=True)

# calculate abs accleration
concatenated_df["abs_acceleration"] = np.linalg.norm(
    concatenated_df[["ACCELEROMETER X (m/s²)", "ACCELEROMETER Y (m/s²)", "ACCELEROMETER Z (m/s²)"]].values, axis=1)
concatenated_df["abs_loc"] = np.linalg.norm(concatenated_df[['LOCATION Latitude : ', 'LOCATION Longitude : ']].values,
                                            axis=1)
fig = px.line(concatenated_df,
              x="date_time",
              y=["ACCELEROMETER X (m/s²)", "ACCELEROMETER Y (m/s²)", "ACCELEROMETER Z (m/s²)"],
              title='Acceleration')
fig.show()

# remove all duplicated long lat positions
unique_coords_df = concatenated_df.groupby('abs_loc').mean().reset_index()

unique_coords_df["gps_acceleration"] = unique_coords_df["LOCATION Speed ( Kmh)"].diff()

unique_coords_df["power"] = unique_coords_df["gps_acceleration"] * unique_coords_df["LOCATION Speed ( Kmh)"] * 80

unique_coords_df.to_csv(
    r"D:\OneDrive - Imperial College London\University Storage\Masters project\Raw data\combined.csv")

fig = px.scatter_mapbox(unique_coords_df,
                        lat="LOCATION Latitude : ",
                        lon="LOCATION Longitude : ",
                        color="LOCATION Speed ( Kmh)",
                        zoom=14)
# fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="abs_acceleration")
# fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="gps_acceleration")
# fig = px.scatter_mapbox(concatenated_df, lat="LOCATION Latitude : ", lon="LOCATION Longitude : ",color="power")

fig.update_layout(mapbox_style="open-street-map")
fig.update_layout(margin={"r": 0, "t": 0, "l": 0, "b": 0})
fig.write_html("plot.html")
fig.show()
