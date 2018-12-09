library(htmlwidgets)
options(tigris_use_cache = TRUE)
library(leaflet)
library(htmltools)
library(tigris)
states = states(cb = TRUE)

production <- read.csv("~/Desktop/Capital Bikeshare Locations Clean.csv")
data2=read.csv("~/Desktop/capital17-18_reduced.csv")

##saturation was defined by frequency of start station minus the frequency of end station
saturation=table(data2$Start.station.number)-table(data2$End.station.number)
s2=data.frame(saturation)
colnames(s2)=c("TERMINAL_NUMBER","saturation")

##merge the saturation with location dataset
merged_df=merge(production,s2,by="TERMINAL_NUMBER")

state_table=table(merged_df$OWNER)
##form a new dataset with number of stations within each state
state_df=data.frame(state_table)
#states=states(cb = TRUE)
state_df_merged= geo_join(states, state_df, "STUSPS", "Var1")
merged_df_2=subset(state_df_merged, !is.na(Freq))

bins=c(0,100,200,500)
pal=colorBin("YlOrRd", domain = state_df$Freq, bins = bins)

# Format popup data for leaflet map.
popup_dat <- paste0("<strong>Terminal_number: </strong>", 
                    merged_df$TERMINAL_NUMBER, 
                    "<br><strong>saturation(frequency difference between the start station and end station): </strong>", 
                    merged_df$saturation)

##make icon
myIcon = makeIcon(
  iconUrl=ifelse(merged_df$saturation < 0,
                 "~/Desktop/yes.png",
                 "~/Desktop/no.jpg"),
                  iconWidth=38, iconHeight=38
)


# load map
us.map = leaflet(merged_df_2) %>%
  addTiles() %>%
  setView(-77.0365, 38.8977,zoom=15) %>%
  addPolygons(data = merged_df_2,
              fillColor = ~pal(state_df$Freq),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7) %>%
  addMarkers(data=merged_df,lat=~LATITUDE, lng=~LONGITUDE, popup=popup_dat, icon=myIcon, clusterOptions = markerClusterOptions()) %>% 
  addLegend(pal = pal, values = state_df$Freq, opacity = 0.7, title = NULL, position = "bottomright")

#us.map
saveWidget(us.map, 'leaflet_1.html', selfcontained = TRUE)
