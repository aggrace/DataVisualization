import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

cabi_loc = pd.read_csv("Capital Bikeshare Locations Clean.csv", sep = ",")

fig = plt.figure()
ax1 = fig.add_subplot(111, projection = "3d")
x = cabi_loc["LONGITUDE"]
y = cabi_loc["LATITUDE"]
z1 = np.zeros(516)
z2 = cabi_loc["NUMBER_OF_EMPTY_DOCKS"]
dx = [.01]*516
dy = [.01]*516
dz1 = cabi_loc["NUMBER_OF_EMPTY_DOCKS"]
dz2 = cabi_loc["NUMBER_OF_BIKES"]

ax1.bar3d(x, y, z1, dx, dy, dz1, color = (.523, .477, .094))
ax1.bar3d(x, y, z2, dx, dy, dz2, color = (.913, .234, .629))
ax1.set_xlabel("Longitude")
ax1.set_ylabel("Latitude")
ax1.set_zlabel("Number")
ax1.set_title("Bikeshare Distribution")
plt.show()