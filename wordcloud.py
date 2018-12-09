
# coding: utf-8

# In[88]:

import pandas as pd
from pandas import DataFrame
import numpy as np
df=pd.read_csv("Capital Bikeshare Locations Clean.csv")

mylist = list(df["ADDRESS"])
mydict = {}

for address in mylist:
    a = re.split(r'( & )|( / )|(/)', address)
    for term in a:
        if term in mydict:
            mydict[term] += 1
        else:
            mydict[term] = 1

del mydict[" & "]
del mydict[" / "]
del mydict["/"]
del mydict[None]
#mask = np.array(Image.open(path.join(d, "cycleimage.jpg")))
#street = WordCloud(background_color = "white", stopwords = None,mask=mask,
 #         min_font_size = 10, collocations = False, random_state = 42).generate_from_frequencies(mydict)
#plt.figure(figsize = (8,8), facecolor = None)
#plt.imshow(street)
#plt.axis("off")
#plt.tight_layout(pad = 0)
#plt.show()


# In[94]:

from os import path, getcwd
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from wordcloud import WordCloud, ImageColorGenerator
d = getcwd()
## image from PublicDomainPictures.net
## http://www.publicdomainpictures.net/view-image.php?image=232185&picture=family-gathering
mask = np.array(Image.open(path.join(d, "cycleimage.jpg")))
wc = WordCloud(background_color="white", max_words=1000, mask=mask,
               max_font_size=90, random_state=42).generate_from_frequencies(mydict)
# create coloring from image
image_colors = ImageColorGenerator(mask)
fig=plt.figure(figsize=[10,10])
plt.imshow(wc.recolor(color_func=image_colors), interpolation="bilinear")
plt.axis("off")
_=plt.show()
fig.savefig('wordcloud.png')


# In[ ]:




# In[ ]:



