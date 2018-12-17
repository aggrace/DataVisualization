library(threejs)
library(htmlwidgets)
library(rgdal)

data=read.csv('~/Desktop/reduced_beijing.csv')

mydf=subset(data,select=c(Lng,Lat,buildingType))

myj3=scatterplot3js(-mydf$Lng,mydf$Lat,mydf$buildingType,
                    axisLabels=c("Longtitude","building Type","Latitude"),
                    size=0.5,
                    color=c("red","yellow")[as.factor(mydf$buildingType)],
                    flip.x=FALSE)

saveWidget(myj3,file="j3ds.html",selfcontained = TRUE)


