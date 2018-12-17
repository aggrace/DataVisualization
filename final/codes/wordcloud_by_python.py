
# coding: utf-8

# In[2]:


from wordcloud import WordCloud


# In[4]:


import csv
word_list=[]

with open("beijing.csv",encoding = "ISO-8859-1") as f:
    reader=csv.reader(f)
    word_list= '\t'.join([i[0] for i in reader])


# In[5]:


wordcloud=WordCloud().generate(word_list)


# In[9]:


import matplotlib.pyplot as plt
f=plt.figure()
plt.imshow(wordcloud,interpolation="bilinear")
plt.axis("off")
plt.show()
f.savefig("wordcloud.jpg")

