#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
__author__ = 'Marcel-Jan Krijgsman'

launch_file_name = "launchlog.txt"

# Definition of columns from fixed fields.
colspecs=[[0,8], [8,32], [40,51], [55,85], [86,111], [112,118], [121,143],
                  [144,159], [160,192], [193,194], [198,211]]
# Names of the columns
colnames=['launch', 'launch_date_utc', 'cospar_nr', 'payload_name', 'orig_payload_name',
          'satcat_nr', 'launchveh_type', 'launch_veh_serie', 'launch_site', 'outcome', 'reference']

# Create dataframe from file with fixed fields.
launch_df = pd.read_fwf(launch_file_name, header=1, colspecs=colspecs, names=colnames)

# print(launch_df)

# Change fields with NaN values to values from the preceding row.
# launch_df.launch = launch_df.launch.ffill()
launch_df.launch = launch_df.launch.fillna(method='ffill')
launch_df.launch_date_utc = launch_df.launch_date_utc.ffill()
launch_df.launchveh_type = launch_df.launchveh_type.ffill()
launch_df.launch_veh_serie = launch_df.launch_veh_serie.ffill()
launch_df.launch_site = launch_df.launch_site.ffill()
launch_df.outcome = launch_df.outcome.ffill()
launch_df.reference = launch_df.reference.ffill()

# Quick look at the results
print(launch_df.iloc[0:100])

# Write the csv file
launch_df.to_csv('launchlog_df.csv', index=False)
