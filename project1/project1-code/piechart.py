import matplotlib.pyplot as plt
 
# Data to plot
labels = 'Casual', 'Member', 'Unknown'
sizes1 = [534770, 283978, 1]
sizes2 = [4296786, 16819638, 57]
sizes3 = [4831557, 17103616, 58]
patches, texts = plt.pie(sizes1, colors=colors, shadow=True, startangle=90)
colors = ['orange', 'yellowgreen', 'lightskyblue']
explode = (0.1, 0, 0) 

# plot 1
plt.title("Rider membership status(return rides)")
plt.pie(sizes1, explode=explode, labels=labels, colors=colors,
        autopct='%1.1f%%', shadow=True, startangle=90)
plt.legend(patches, labels, loc="best")
plt.axis('equal')
plt.show()
# plot 2
plt.title("Rider membership status(one-way rides)")
plt.pie(sizes2, explode=explode, labels=labels, colors=colors,
        autopct='%1.1f%%', shadow=True, startangle=90)
plt.legend(patches, labels, loc="best")
plt.axis('equal')
plt.show()
# plot 3
plt.title('Rider membership status(all)')
plt.pie(sizes3, explode=explode, labels=labels, colors=colors,
        autopct='%1.1f%%', shadow=True, startangle=90)
plt.legend(patches, labels, loc="best")
plt.axis('equal')
plt.show()