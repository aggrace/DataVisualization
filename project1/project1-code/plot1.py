#!/usr/bin/env python
# coding: utf-8

# In[2]:


import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import matplotlib.dates as mdates
from dateutil import parser
import seaborn as sns


# In[3]:


bike = pd.read_csv("~/Desktop/Capital Bikeshare Locations Clean.csv")
cabi_loc = pd.read_csv("Capital Bikeshare Locations Clean.csv")


# In[13]:


sns.jointplot(x='NUMBER_OF_BIKES',y='NUMBER_OF_DOCKS',data=bike,kind='hex')


# In[20]:


x = np.array(cabi_loc["LONGITUDE"])
y = np.array(cabi_loc["LATITUDE"])

sns.set(style="dark")
f, axes = plt.subplots(figsize=(9, 9))
cmap = sns.cubehelix_palette(start=0, light=1, as_cmap=True)
sns.kdeplot(x, y, cmap=cmap, shade=True, cut=5, ax=axes)
f.suptitle("Capital Bikeshare Location Density", size=16)


# In[ ]:




