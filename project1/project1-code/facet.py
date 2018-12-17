# -*- coding: utf-8 -*-
"""
Created on Wed Oct 10 14:03:43 2018

@author: Yigao
"""

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import datetime
import pytz

cabi = pd.read_csv("capital17-18_full.csv", sep = ",")
cabi_loc = pd.read_csv("Capital Bikeshare Locations Clean.csv", sep = ",")

cabi["Start.date"] = pd.to_datetime(cabi["Start.date"], format = "%Y-%m-%d %H:%M:%S")
cabi["End.date"] = pd.to_datetime(cabi["End.date"], format = "%Y-%m-%d %H:%M:%S")
cabi["Day.of.week"] = cabi["Start.date"].dt.dayofweek
cabi["Hour.of.day"] = pd.DatetimeIndex(cabi["Start.date"]).hour

result = pd.read_csv("hourly_day_of_week_1.csv", sep = ",")

cabi_sub = cabi.loc[cabi["Member.type"] == "Casual"]
result = cabi_sub.groupby(["Day.of.week", "Hour.of.day"]).agg(["count"])
result.to_csv("hourly_day_of_week.csv")
## seaborn subplots ##
sns.set()
g = sns.FacetGrid(result, col = "Day.of.week", col_wrap = 5)
g = g.map(plt.plot, "Hour.of.day", "Usage", marker = ".")
g.set_xlabels("Time")
g.fig.suptitle("Capital Bikeshare Hourly Usage in a Week", size=16)
g.fig.subplots_adjust(top=.9)