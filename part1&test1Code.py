
# coding: utf-8

# In[1]:


import numpy as np
from PIL import Image
import glob 


# In[4]:


#loading images
import os
fp='../individual-assignment-2/FACESdata'
def getAllPath(fp):
    file_list = []
    dir_list = []
    path_dir = os.listdir(fp)
    for s in path_dir:
        new_dir = fp + '/' + s
        if os.path.isfile(new_dir):
            file_list.append(new_dir)
        elif os.path.isdir(new_dir):
            dir_list.append(new_dir)
    return dir_list, file_list

dir_list, file_list = getAllPath(fp)


# In[5]:


matrix = []
paths = []
for dir in dir_list:
    dir_list_2, file_list_2 = getAllPath(dir)
    file_counter = 0
    
    for fullpath in file_list_2:
        img = Image.open(fullpath).convert('L')
        imagearray=np.array(img)
        original_shape=imagearray.shape
        flat=imagearray.ravel()
        matrix.append(flat)
        paths.append(fullpath)
        file_counter=file_counter+1
        
    print("finish folder: " + str(dir))
    print(str(dir) + " has " + str(file_counter) + " files" + '\n')

facematrix=np.array(matrix).T
print("The facematrix is" + '\n')
print(facematrix)
print("The shape of facematrix is" + '\n', facematrix.shape)


# In[7]:


facematrix_t=np.transpose(facematrix)
print(facematrix_t)
print(facematrix_t.shape)


# In[10]:


##Calculate the mean face for all images
mean_face_vector=np.mean(facematrix,axis=1)
import matplotlib.pyplot as plt
print(mean_face_vector)
print(mean_face_vector.shape)
f = plt.figure()
plt.imshow(mean_face_vector.reshape(original_shape), cmap = plt.get_cmap("gray"))
plt.show()
f.savefig("meanface.jpg")
#print(mean_face_vector.shape)


# In[11]:


##To get the Normalized face matrix and shape of it
import numpy as np
import matplotlib.pyplot as plt
Norm_Face_Matrix=facematrix - mean_face_vector.reshape([10304,1])
print(Norm_Face_Matrix)
print(Norm_Face_Matrix.shape)


# In[12]:


#Get the covariance matrix
Norm_Face_Matrix_t=np.transpose(Norm_Face_Matrix)
CovMatrix=np.matmul(Norm_Face_Matrix_t,Norm_Face_Matrix)
print("The covariance matrix is \n",CovMatrix)
print(CovMatrix.shape)


# In[13]:


evals,evects=np.linalg.eig(CovMatrix)
index=evals.argsort()[::-1]
evals=evals[index]
evects=evects[:,index]
print(evals[0:5])
print(evects[:,0:5])


# In[15]:


#Get the eigenface matrix with the number of top k eigen values(k is user defined)
num=int(input("Enter the number of top eigenvalues you want to get(must be less or equal to 400):"))
eigenface_matrix=np.matmul(Norm_Face_Matrix,evects[:,0:num])
print("The eigenface matrix is: ",eigenface_matrix)
print(eigenface_matrix.shape)


# In[16]:


##print top 5 eigenvalues and eigenvectors
top5eigenValues=evals[:5]
top5eigenVectors=evects[:5]
##Save those into txt
np.savetxt('top5EigenValues.txt',top5eigenValues)
np.savetxt('top5EigenVectors.txt',top5eigenVectors)


# In[36]:


for i in range(5):
    f = plt.figure()
    plt.imshow(eigenface_matrix[:,i].reshape(original_shape), cmap = plt.get_cmap("gray"))
    plt.show()
    f.savefig("writeup/first5/eigenface_{}.jpg".format(i+1))


# In[37]:


###Testing a face
##Read test image
test_image=Image.open('writeup/test1/TEST_Image.jpg').convert('L')
plt.imshow(test_image,cmap=plt.get_cmap('gray'))
plt.show()

##Vectorize test image
test_image_flat=np.array(test_image).ravel()
test_image_vector=np.matrix(test_image_flat)

##Normalize the image
Norm_Test_Face=test_image_vector - mean_face_vector

#Project the normalized test face into the eigenfaces matrix reduced space
Projection=np.matmul(eigenface_matrix.T,Norm_Test_Face.T)


# In[38]:


from scipy.spatial import distance
dist = [0 for i in range(400)]
b=np.zeros([400,10])

for i in range (400):   
    a=np.matmul(eigenface_matrix.T,Norm_Face_Matrix[:,i]) 
    b[i,:] = np.transpose(a)
    dist[i] = np.sum(np.square(b[i,:] - np.transpose(Projection)))
    
num = dist.index(min(dist))
print("The closet file number is ",num, "and euclidean distance is: ", min(dist))
result_image = Image.open(paths[num]).convert('L')
f=plt.figure()
plt.imshow(result_image, cmap = plt.get_cmap("gray"))
plt.show()

f.savefig("writeup/test1/PREDICTED_Image.jpg")

