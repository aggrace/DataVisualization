
# coding: utf-8

# In[1]:


import numpy as np
from PIL import Image
import glob 


# In[2]:


#First convert just one image into vector
import os
fp='../503/FACESdata2'
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


# In[3]:


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


# In[4]:


facematrix_t=np.transpose(facematrix)
print(facematrix_t)
print(facematrix_t.shape)


# In[5]:


##Calculate the mean face for all images
mean_face_vector=np.mean(facematrix,axis=1)
import matplotlib.pyplot as plt
print(mean_face_vector)
print(mean_face_vector.shape)
#f = plt.figure()
plt.imshow(mean_face_vector.reshape(original_shape), cmap = plt.get_cmap("gray"))
plt.show()
#f.savefig("mean_face.jpg")
#print(mean_face_vector.shape)


# In[6]:


import numpy as np
import matplotlib.pyplot as plt
Norm_Face_Matrix=facematrix - mean_face_vector.reshape([10304,1])
print(Norm_Face_Matrix)
print(Norm_Face_Matrix.shape)


# In[7]:


#Get the covariance matrix
Norm_Face_Matrix_t=np.transpose(Norm_Face_Matrix)
CovMatrix=np.matmul(Norm_Face_Matrix_t,Norm_Face_Matrix)
print("The covariance matrix is \n",CovMatrix)
print(CovMatrix.shape)


# In[8]:


evals,evects=np.linalg.eig(CovMatrix)
index=evals.argsort()[::-1]
evals=evals[index]
evects=evects[:,index]


# In[9]:


#Get the eigenface matrix with the number of top k eigen values(k is user defined)
num=int(input("Enter the number of top eigenvalues you want to get(must be less or equal to 400):"))
eigenface_matrix=np.matmul(Norm_Face_Matrix,evects[:,0:num])
print("The eigenface matrix is: ",eigenface_matrix)
print(eigenface_matrix.shape)


# In[10]:


###Test2
test_2=Image.open('../503/TEST_Image_2.pgm')
plt.imshow(test_2,cmap=plt.get_cmap('gray'))
plt.show()


# In[11]:


##Vectorize test image 2
test_image_2_flat=np.array(test_2).ravel()
test_image_2_vector=np.matrix(test_image_2_flat)

##Normalize the image
Norm_Test_Face_2=test_image_2_vector - mean_face_vector

#Project the normalized test face into the eigenfaces matrix reduced space
Projection_2=np.matmul(eigenface_matrix.T,Norm_Test_Face_2.T)


# In[17]:


from scipy.spatial import distance
dist2 = [0 for i in range(400)]
b2=np.zeros([400,10])

for i in range (400):   
    a=np.matmul(eigenface_matrix.T,Norm_Face_Matrix[:,i]) 
    b2[i,:] = np.transpose(a)
    dist2[i] = np.sum(np.square(b2[i,:] - np.transpose(Projection_2)))
    
num2 = dist2.index(sorted(dist2)[1])
print("The closet file number is ",num2, "and euclidean distance is: ", sorted(dist2)[1])
result_image_2 = Image.open(paths[num2]).convert('L')
f=plt.figure()
plt.imshow(result_image_2, cmap = plt.get_cmap("gray"))
plt.show()
f.savefig('../503/individual-assignment-2/test2/PREDICTED_Image_2.jpg')

