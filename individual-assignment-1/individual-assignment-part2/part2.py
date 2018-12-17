
# coding: utf-8

# In[1]:


from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import euclidean_distances
from sklearn.metrics.pairwise import cosine_similarity
import matplotlib.pyplot as plt
from sklearn.manifold import MDS
from mpl_toolkits.mplot3d import Axes3D
from scipy.cluster.hierarchy import ward,dendrogram


# In[58]:


import glob
mylist = [f for f in glob.glob("../503/individual-assignment-part2/*.txt")]
mylist


# In[69]:


#print(mylist[0][35:-4])
for i in mylist:
    names=i[35:-4]
    print(names)
    


# In[6]:


vectorizer=CountVectorizer(input='filename')
dtm=vectorizer.fit_transform(mylist)
print(type(dtm))
vocab=vectorizer.get_feature_names()
dtm=dtm.toarray()
print(list(vocab)[500:550])

#house_idx=list(vocab).index('house')
#print(house_idx)


# In[9]:


house_idx=list(vocab).index('house')
print(house_idx)


# In[10]:


print(dtm[1,house_idx])


# In[11]:


print(list(vocab)[house_idx])


# In[12]:


print(dtm)


# In[13]:


##create a table of word counts to compare Emma and Pride and Prejudice
columns=['Bookname','house','and','almost']
mylist=['Emma']
mylist2=['Pride']
mylist3=['Sense']
for someword in ['house','and','almost']:
    EmmaWord=(dtm[0,list(vocab).index(someword)])
    mylist.append(EmmaWord)
    PrideWord=(dtm[1,list(vocab).index(someword)])
    mylist.append(PrideWord)
    SenseWord=(dtm[2,list(vocab).index(someword)])
    mylist.append(SenseWord)
    df2=pd.DataFrame([columns,mylist,mylist2,mylist3])
    print(df2)


# In[14]:


dist=euclidean_distances(dtm)
print(np.round(dist,0))


# In[15]:


cosdist=1-cosine_similarity(dtm)
print(np.round(cosdist,3))


# In[80]:


mds=MDS(n_components=2,dissimilarity='precomputed',random_state=1)
pos=mds.fit_transform(cosdist)
xs,ys=pos[:,0],pos[:,1]
names=[]
for i in mylist:
    names.append(i[35:-4])

for x,y,name in zip(xs,ys,names):
    plt.scatter(x,y)
    plt.text(x,y,name)
    plt.title('Similarity between books')
    #plt.show()


# In[77]:


mds=MDS(n_components=3,dissimilarity="precomputed",random_state=1)
pos=mds.fit_transform(cosdist)
fig=plt.figure()
ax=fig.add_subplot(111,projection='3d')
ax.scatter(pos[:,0],pos[:,1],pos[:,2])
for x,y,z,s in zip(pos[:,0],pos[:,1],pos[:,2],names):
    ax.text(x,y,z,s)
    
ax.set_xlim3d(-.05,0.07)
ax.set_ylim3d(-0.008,0.008)
ax.set_zlim3d(-.05,0.05)
plt.title('Similarity between books')
plt.show()


# In[82]:


linkage_matrix=ward(cosdist)
dendrogram(linkage_matrix,orientation="right",labels=names)
plt.tight_layout()
plt.title('ward clustering of similarity between books visualization')
plt.show()

