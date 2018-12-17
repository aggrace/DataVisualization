#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 18 11:52:48 2018

@author: jiawei
"""

import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import matplotlib.dates as mdates
from dateutil import parser
import seaborn as sns

# Data for plotting

whourly = pd.read_csv("~/Desktop/weather_hourly_2017-2018.csv")
wdaily = pd.read_csv("~/Desktop/weather_daily_2017-2018.csv")


# 读取米兰的城市气象数据
#df_milano = pd.read_csv('milano_270615.csv')
 
# 取出我们要分析的温度和日期数据
#y1 = wdaily1['temperatureHigh']
#x1 = wdaily1['time']
y1 = wdaily['precipIntensity']
x1 = wdaily['time']

y1 = whourly['visibility']
x1 = whourly['time']

#y2 = wdaily['temperatureHigh']
#x2 = wdaily['time']
 

day_milano = [parser.parse(x) for x in x1]

fig, ax = plt.subplots()
 

plt.xticks(rotation=70)
 

days = mdates.DateFormatter('%Y-%m-%d')

 

ax.xaxis.set_major_formatter(days)
 

ax.plot(day_milano ,y1, 'b')
#ax.plot(day_milano1 ,y2, 'r')
plt.title("PrecipIntensity Changes of Washingotn dc, 2017-2018")
plt.xlabel('Day')
plt.ylabel('PrecipIntensity')

fig



df3 = whourly[['temperature','precipIntensity','humidity','visibility']].copy()
plt.title("Area of temperature, precipIntensity, humidity, visibility in Washingotn dc, 2017-2018")
#plt.xlabel('PrecipIntensity')
#plt.ylabel('Distribution')
df3.plot.area()


fig, ax = plt.subplots(figsize=(5, 3))
ax.stackplot(days, rng + rnd, labels=['Eastasia', 'Eurasia', 'Oceania'])
ax.set_title('Combined debt growth over time')
ax.legend(loc='upper left')
ax.set_ylabel('Total debt')
ax.set_xlim(xmin=yrs[0], xmax=yrs[-1])
fig.tight_layout()




rng = np.arange(50)
rnd = np.random.randint(0, 10, size=(3, rng.size))
print(rnd)






######################################

import pandas as pd
import numpy as np
from sklearn import preprocessing

hourly = pd.read_csv('~/Desktop/hourly.csv')

scaler = preprocessing.MinMaxScaler()

df3 = hourly[['temperature','precipIntensity','humidity','visibility']].copy()
#dfTest = pd.DataFrame({'A':[14.00,90.20,90.95,96.27,91.21],'B':[103.02,107.26,110.35,114.23,114.68], 'C':['big','small','big','small','small']})
min_max_scaler = preprocessing.MinMaxScaler()

def scaleColumns(df, cols_to_scale):
    for col in cols_to_scale:
        df[col] = pd.DataFrame(min_max_scaler.fit_transform(pd.DataFrame(df3[col])),columns=[col])
    return df

df = scaleColumns(df3, )

df3['temperature'] = pd.DataFrame(min_max_scaler.fit_transform(pd.DataFrame(df3['temperature'])),columns=['temperature'])
df3['precipIntensity'] = pd.DataFrame(min_max_scaler.fit_transform(pd.DataFrame(df3['precipIntensity'])),columns=['precipIntensity'])
df3['humidity'] = pd.DataFrame(min_max_scaler.fit_transform(pd.DataFrame(df3['humidity'])),columns=['humidity'])
df3['visibility'] = pd.DataFrame(min_max_scaler.fit_transform(pd.DataFrame(df3['visibility'])),columns=['visibility'])



plt.stackplot(days, df3['temperature'],df3['precipIntensity'],df3['humidity'],df3['visibility'], colors=['m','c','r','k'])

df3 = df3.set_index(hourly['time'])
df3.plot.area()
plt.title("temperature, precipIntensity, humidity, visibility of Washingotn dc, 2017-2018")
plt.xlabel('Hours')
plt.ylabel('value')
ax.set_xticklabels(day_milano, rotation=0)
plt.xlim(day_milano)

df3['visibility']

ax.plot(day_milano ,df3['visibility'], 'b')
#ax.plot(day_milano1 ,y2, 'r')
plt.title("PrecipIntensity Changes of Washingotn dc, 2017-2018")
plt.xlabel('Day')
plt.ylabel('PrecipIntensity')
# 显示图像
fig

df3['visibility'].isnull().sum().sum()







plt.plot([],[],color='m', label='temperature', linewidth=5)
plt.plot([],[],color='c', label='precipIntensity', linewidth=5)
plt.plot([],[],color='r', label='humidity', linewidth=5)
plt.plot([],[],color='k', label='visibility', linewidth=5)

plt.stackplot(whourly['time'], df3['temperature'],df3['precipIntensity'],df3['humidity'],df3['visibility'], colors=['m','c','r','k'])
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()








labels = ["temperature ", "precipIntensity", "humidity",'visibility']

fig, ax = plt.subplots()
ax.stackplot(day_milano, df3['temperature'],df3['precipIntensity'],df3['humidity'],df3['visibility'], labels=labels)
ax.legend(loc='upper left')
plt.show()

