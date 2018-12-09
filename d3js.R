library(threejs)
library(htmlwidgets)
library(rgdal)
cabiloc <- read.csv("Capital Bikeshare Locations Clean.csv")

mydf <- subset(cabiloc, select = c(LATITUDE, LONGITUDE, NUMBER_OF_DOCKS))

MyJ3 <- scatterplot3js(-mydf$LATITUDE, mydf$LONGITUDE, mydf$NUMBER_OF_DOCKS,
                       axisLabels = c("Latitude", "Docks Installed", "Longitude"),
                       size = mydf$NUMBER_OF_DOCKS/40,
                       color = col,
                       flip.x = FALSE)
saveWidget(MyJ3, file = "rotatable_d3js.html", selfcontained = TRUE, libdir = NULL, background = "white")