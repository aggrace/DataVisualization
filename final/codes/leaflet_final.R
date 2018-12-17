library(leaflet)
library(leafletCN)
library(leaflet.extras)
library(sp)
library(maps)
library(mapdata)
library(rgdal)
library(ggmap)
library(dplyr)
library(mapproj)
library(htmlwidgets)

data=read.csv(file="~/Desktop/reduced_beijing.csv")

popup_dat <- paste0("<strong>number of followers: </strong>", 
                    data$followers,
                    "<br><strong>price: </strong>", 
                    data$price)
popup_dat2 <- paste0("<strong>number of bathroom: </strong>", 
                     data$bathRoom,
                     "<br><strong>number of kitchen: </strong>", 
                     data$kitchen)

if(require(leaflet)){
  region=regionNames("北京")
  #dat=data.frame(data$Lat)
  dat = data.frame(region,runif(length(region)))
  map = leafletGeo("北京", dat)
  
  merged_df=merge(map, data, by.x="cp1", by.y="Lng")
 # map = leafletGeo("北京")
  
  #涂色环节
  pal <- colorNumeric(
    palette = "Blues",
    domain = map$value)
  
  #载入高德地图amap
gmap=leaflet(data=merged_df) %>% 
    amap(group = "amap") %>%
    #加入框边界及颜色
    addPolygons(#data=map,
                stroke = TRUE,
                smoothFactor = 1,
                fillOpacity = 0.7,
                weight = 1,
                color = ~pal(value),
                popup = ~htmltools::htmlEscape(popup)
    ) %>%
    addMarkers(data=data,lat=~Lat, lng=~Lng,popup=popup_dat,group=c("followers and price"),
               clusterOptions = markerClusterOptions()) %>%
    addMarkers(data=data,lat=~Lat, lng=~Lng,popup=popup_dat2, group=c("bathroom and kitchen distribution"),
               clusterOptions = markerClusterOptions()) %>%
    #加入右下角边框
    addLegend("bottomright", pal = pal, values = ~value,
              title = "Administrative region",
              labFormat = leaflet::labelFormat(prefix = ""),
              opacity = 1) %>%
    
    addLayersControl(
    baseGroups = c("amap"),
    overlayGroups = c("followers and price","bathroom and kitchen distribution"),
    options = layersControlOptions(collapsed = FALSE)
  )
saveWidget(gmap, 'leafletmap_final.html', selfcontained = TRUE)

}


