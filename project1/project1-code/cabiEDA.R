library(ggplot2)
library(scales)
library(reshape2)

# Download Capital Bikeshare datasets to temp files, unzip, read datasets to data frame and delete temp files

temp2010 = tempfile()
temp2011 = tempfile()
temp2012 = tempfile()
temp2013 = tempfile()
temp2014 = tempfile()
temp2015 = tempfile()
temp2016 = tempfile()
temp2017 = tempfile()
temp201801 = tempfile()
temp201802 = tempfile()
temp201803 = tempfile()
temp201804 = tempfile()
temp201805 = tempfile()
temp201806 = tempfile()
temp201807 = tempfile()
temp201808 = tempfile()
temp201809 = tempfile()

download.file("https://s3.amazonaws.com/capitalbikeshare-data/2010-capitalbikeshare-tripdata.zip", temp2010)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2011-capitalbikeshare-tripdata.zip", temp2011)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2012-capitalbikeshare-tripdata.zip", temp2012)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2013-capitalbikeshare-tripdata.zip", temp2013)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2014-capitalbikeshare-tripdata.zip", temp2014)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2015-capitalbikeshare-tripdata.zip", temp2015)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2016-capitalbikeshare-tripdata.zip", temp2016)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2017-capitalbikeshare-tripdata.zip", temp2017)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201801-capitalbikeshare-tripdata.zip", temp201801)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201802-capitalbikeshare-tripdata.zip", temp201802)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201803-capitalbikeshare-tripdata.zip", temp201803)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201804-capitalbikeshare-tripdata.zip", temp201804)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201805-capitalbikeshare-tripdata.zip", temp201805)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201806-capitalbikeshare-tripdata.zip", temp201806)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201807-capitalbikeshare-tripdata.zip", temp201807)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201808-capitalbikeshare-tripdata.zip", temp201808)
download.file("https://s3.amazonaws.com/capitalbikeshare-data/201809-capitalbikeshare-tripdata.zip", temp201809)

cabi2010 = unzip(temp2010, files = "2010-capitalbikeshare-tripdata.csv")
cabi2011 = unzip(temp2011, files = "2011-capitalbikeshare-tripdata.csv")
cabi2012q1 = unzip(temp2012, files = "2012Q1-capitalbikeshare-tripdata.csv")
cabi2012q2 = unzip(temp2012, files = "2012Q2-capitalbikeshare-tripdata.csv")
cabi2012q3 = unzip(temp2012, files = "2012Q3-capitalbikeshare-tripdata.csv")
cabi2012q4 = unzip(temp2012, files = "2012Q4-capitalbikeshare-tripdata.csv")
cabi2013q1 = unzip(temp2013, files = "2013Q1-capitalbikeshare-tripdata.csv")
cabi2013q2 = unzip(temp2013, files = "2013Q2-capitalbikeshare-tripdata.csv")
cabi2013q3 = unzip(temp2013, files = "2013Q3-capitalbikeshare-tripdata.csv")
cabi2013q4 = unzip(temp2013, files = "2013Q4-capitalbikeshare-tripdata.csv")
cabi2014q1 = unzip(temp2014, files = "2014Q1-capitalbikeshare-tripdata.csv")
cabi2014q2 = unzip(temp2014, files = "2014Q2-capitalbikeshare-tripdata.csv")
cabi2014q3 = unzip(temp2014, files = "2014Q3-capitalbikeshare-tripdata.csv")
cabi2014q4 = unzip(temp2014, files = "2014Q4-capitalbikeshare-tripdata.csv")
cabi2015q1 = unzip(temp2015, files = "2015Q1-capitalbikeshare-tripdata.csv")
cabi2015q2 = unzip(temp2015, files = "2015Q2-capitalbikeshare-tripdata.csv")
cabi2015q3 = unzip(temp2015, files = "2015Q3-capitalbikeshare-tripdata.csv")
cabi2015q4 = unzip(temp2015, files = "2015Q4-capitalbikeshare-tripdata.csv")
cabi2016q1 = unzip(temp2016, files = "2016Q1-capitalbikeshare-tripdata.csv")
cabi2016q2 = unzip(temp2016, files = "2016Q2-capitalbikeshare-tripdata.csv")
cabi2016q3 = unzip(temp2016, files = "2016Q3-capitalbikeshare-tripdata.csv")
cabi2016q4 = unzip(temp2016, files = "2016Q4-capitalbikeshare-tripdata.csv")
cabi2017q1 = unzip(temp2017, files = "2017Q1-capitalbikeshare-tripdata.csv")
cabi2017q2 = unzip(temp2017, files = "2017Q2-capitalbikeshare-tripdata.csv")
cabi2017q3 = unzip(temp2017, files = "2017Q3-capitalbikeshare-tripdata.csv")
cabi2017q4 = unzip(temp2017, files = "2017Q4-capitalbikeshare-tripdata.csv")
cabi201801 = unzip(temp201801, files = "201801_capitalbikeshare_tripdata.csv")
cabi201802 = unzip(temp201802, files = "201802-capitalbikeshare-tripdata.csv")
cabi201803 = unzip(temp201803, files = "201803-capitalbikeshare-tripdata.csv")
cabi201804 = unzip(temp201804, files = "201804-capitalbikeshare-tripdata.csv")
cabi201805 = unzip(temp201805, files = "201805-capitalbikeshare-tripdata.csv")
cabi201806 = unzip(temp201806, files = "201806-capitalbikeshare-tripdata.csv")
cabi201807 = unzip(temp201807, files = "201807-capitalbikeshare-tripdata.csv")
cabi201808 = unzip(temp201808, files = "201808-capitalbikeshare-tripdata.csv")
cabi201809 = unzip(temp201809, files = "201809-capitalbikeshare-tripdata.csv")

cabi2010.df = read.csv(cabi2010)
cabi2011.df = read.csv(cabi2011)
cabi2012q1.df = read.csv(cabi2012q1)
cabi2012q2.df = read.csv(cabi2012q2)
cabi2012q3.df = read.csv(cabi2012q3)
cabi2012q4.df = read.csv(cabi2012q4)
cabi2013q1.df = read.csv(cabi2013q1)
cabi2013q2.df = read.csv(cabi2013q2)
cabi2013q3.df = read.csv(cabi2013q3)
cabi2013q4.df = read.csv(cabi2013q4)
cabi2014q1.df = read.csv(cabi2014q1)
cabi2014q2.df = read.csv(cabi2014q2)
cabi2014q3.df = read.csv(cabi2014q3)
cabi2014q4.df = read.csv(cabi2014q4)
cabi2015q1.df = read.csv(cabi2015q1)
cabi2015q2.df = read.csv(cabi2015q2)
cabi2015q3.df = read.csv(cabi2015q3)
cabi2015q4.df = read.csv(cabi2015q4)
cabi2016q1.df = read.csv(cabi2016q1)
cabi2016q2.df = read.csv(cabi2016q2)
cabi2016q3.df = read.csv(cabi2016q3)
cabi2016q4.df = read.csv(cabi2016q4)
cabi2017q1.df = read.csv(cabi2017q1)
cabi2017q2.df = read.csv(cabi2017q2)
cabi2017q3.df = read.csv(cabi2017q3)
cabi2017q4.df = read.csv(cabi2017q4)
cabi201801.df = read.csv(cabi201801)
cabi201802.df = read.csv(cabi201802)
cabi201803.df = read.csv(cabi201803)
cabi201804.df = read.csv(cabi201804)
cabi201805.df = read.csv(cabi201805)
cabi201806.df = read.csv(cabi201806)
cabi201807.df = read.csv(cabi201807)
cabi201808.df = read.csv(cabi201808)
cabi201809.df = read.csv(cabi201809)

unlink(temp2010)
unlink(temp2011)
unlink(temp2012)
unlink(temp2013)
unlink(temp2014)
unlink(temp2015)
unlink(temp2016)
unlink(temp2017)
unlink(temp201801)
unlink(temp201802)
unlink(temp201803)
unlink(temp201804)
unlink(temp201805)
unlink(temp201806)
unlink(temp201807)
unlink(temp201808)
unlink(temp201809)

# Combine data to a single data frame and write a .csv file

data.names <- list(cabi2010.df, cabi2011.df,
                   cabi2012q1.df, cabi2012q2.df, cabi2012q3.df, cabi2012q4.df,
                   cabi2013q1.df, cabi2013q2.df, cabi2013q3.df, cabi2013q4.df,
                   cabi2014q1.df, cabi2014q2.df, cabi2014q3.df, cabi2014q4.df,
                   cabi2015q1.df, cabi2015q2.df, cabi2015q3.df, cabi2015q4.df,
                   cabi2016q1.df, cabi2016q2.df, cabi2016q3.df, cabi2016q4.df,
                   cabi2017q1.df, cabi2017q2.df, cabi2017q3.df, cabi2017q4.df,
                   cabi201801.df, cabi201802.df, cabi201803.df,
                   cabi201804.df, cabi201805.df, cabi201806.df,
                   cabi201807.df, cabi201808.df, cabi201809.df)

mult.merge <- function(dataframes) {
  data1 <- dataframes[1]
  for (data2 in dataframes[-1]){
    data1 <- merge.data.frame(data1, data2, all = TRUE, sort = FALSE)
  }
  return(data1)
}

full.df <- mult.merge(data.names)
write.csv(full.df, file = "capital.csv", row.names = FALSE)

## Read Capital Bikeshare dataset from 2010/09 to 2018/09
cabi <- read.csv("C:/capital.csv")

## Remove station name columns to reduce file size
cabi <- subset(cabi, select = -c(Start.station, End.station))

## Write reduced file to .csv
write.csv(cabi, "C:/capital reduced.csv", row.names = FALSE)

## Restart RStudio and load reduced dataset again
cabi <- read.csv("C:/capital reduced.csv")
cabi.loc <- read.csv("D:/Courses/ANLY 503/Project/Capital Bikeshare Locations Clean.csv")

## Remove data in record file but not in location file.
setdiff(cabi$Start.station.number, cabi.loc$TERMINAL_NUMBER)
setdiff(cabi$End.station.number, cabi.loc$TERMINAL_NUMBER)
cabi <- subset(cabi, (Start.station.number %in% cabi.loc$TERMINAL_NUMBER) & (End.station.number %in% cabi.loc$TERMINAL_NUMBER))
cabi$Start.station.number <- as.factor(cabi$Start.station.number)
cabi$End.station.number <- as.factor(cabi$End.station.number)

## Subset rental bike returns to the same location
cabi.return <- subset(cabi, Start.station.number == End.station.number)
cabi.return$Start.station.number <- as.factor(cabi.return$Start.station.number)
cabi.return$End.station.number <- as.factor(cabi.return$End.station.number)
write.csv(cabi.return, "C:/capital same location.csv", row.names = FALSE)
cabi.return <- read.csv("C:/capital same location.csv")

cabi <- subset(cabi, Start.station.number != End.station.number)

#######################################
#### Pie Chart ####################
##################################

## Member type plot of return samples
member.df1 <- data.frame(type = c("Member", "Casual", "Unknown"), value = c(283978, 534770, 1))
member.pie1 <- ggplot(member.df1, aes(x = "", y = value, fill = type))+
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label = paste0(value, " ", percent(value/818749))), position = position_stack(vjust = 0.5), size = 5)+
  coord_polar(theta = "y") +
  ggtitle("Riders membership status (return rides)") +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())
member.pie1

## Member type plot of oneway samples
member.df2 <- data.frame(type = c("Member", "Casual", "Unknown"), value = c(16819638, 4296786, 57))
member.pie2 <- ggplot(member.df2, aes(x = "", y = value, fill = type))+
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label = paste0(value, " ", percent(value/21116482))), position = position_stack(vjust = 0.5), size = 5)+
  coord_polar(theta = "y") +
  ggtitle("Riders membership status (one-way rides)") +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())
member.pie2

## Member type plot of entire dataset
member.df3 <- data.frame(type = c("Member", "Casual", "Unknown"), value = c(17103616, 4831557, 58))
member.pie3 <- ggplot(member.df3, aes(x = "", y = value, fill = type))+
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label = paste0(value, " ", percent(value/21935231))), position = position_stack(vjust = 0.5), size = 5)+
  coord_polar(theta = "y") +
  ggtitle("Riders membership status (all)") +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())
member.pie3

####################################
##### Z Score for 2 Population #######
##################################
casual <- c(534770, 4296786)
total <- c(818749, 21116482)
test <- prop.test(x = casual, n = total, alternative = "two.sided", conf.level = 0.95)
test

## Most frequent start&end pairs
start.end.pairs <- table(cabi$Start.station.number, cabi$End.station.number)
return.pairs <- table(cabi.return$Start.station.number, cabi.return$End.station.number)
## Function topNpairs returns start and end station number given 2-way table, output = 2 for one-way and 1 for return
topNpairs <- function(n, pairs.table, output = 2){
  topN <- sort(pairs.table, decreasing = TRUE)[1:n]
  for (i in topN){
    indices <- which(pairs.table == i, arr.ind = TRUE)
    if (output == 2){
      cat(colnames(pairs.table)[indices[1]], colnames(pairs.table)[indices[2]], "\n")
    }
    if (output == 1){
      cat(colnames(pairs.table)[indices[1]], ", ", sep = "")
    }
  }
}
topNpairs(140, start.end.pairs, output = 2)
topNpairs(140, return.pairs, output = 1)

## Direction (dealing with entire dataset)
cabi$Start.state <- cabi.loc$OWNER[match(cabi$Start.station.number, cabi.loc$TERMINAL_NUMBER)]
cabi$End.state <- cabi.loc$OWNER[match(cabi$End.station.number, cabi.loc$TERMINAL_NUMBER)]
cabi$Start.city <- cabi.loc$CITY[match(cabi$Start.station.number, cabi.loc$TERMINAL_NUMBER)]
cabi$End.city <- cabi.loc$CITY[match(cabi$End.station.number, cabi.loc$TERMINAL_NUMBER)]
state.pairs <- table(cabi$Start.state, cabi$End.state)
city.pairs <- table(cabi$Start.city, cabi$End.city)

feature <- c(rep("dock", 3), rep("usage", 3))
state <- rep(c("DC", "MD", "VA"), 2)
proportion <- c(.535, .174, .291, .902, .012, .086)
bar.data <- data.frame(feature, state, proportion)

######################
# Dock VS Bike    
########################

bar.hori <- ggplot(bar.data, aes(x = state, y = proportion, fill = feature)) +
  geom_bar(position = "dodge", stat = "identity", aes(y = proportion)) +
  coord_flip() +
  scale_y_continuous(labels = percent) +
  ggtitle("Dock Installation and Bike Usage")
bar.hori

##########################
##### BOXPLOT HISTOGRAM #####
###########################

boxplot(cabi$Duration)
hist(cabi$Duration, nclass = 100)
duration.box <- qplot(x = "", y = Duration, data = cabi, geom = "boxplot") +
  coord_cartesian(ylim = c(60, 2500))
duration.box

###############################
### Data Cleaning (Duration) ###
###############################

plt2 <- ggplot() +
  geom_boxplot(data = cabi, mapping = aes(x = "", y = Duration), outlier.alpha = 0.01, notch = TRUE) +
  theme(axis.title.x = element_blank()) +
  labs(title = "Time Duration of all Rides (before cleaning)", subtitle = "in seconds")
plt2

# limit duration within 47 minutes
cabi.sub <- cabi[which(cabi$Duration <= 2820),]

plt3 <- ggplot() +
  geom_boxplot(data = cabi.sub, mapping = aes(x = "", y = Duration), notch = TRUE) +
  theme(axis.title.x = element_blank()) +
  labs(title = "Time Duration of all Rides (after cleaning)", subtitle = "in seconds")
plt3

plt4 <- ggplot() +
  geom_histogram(data = cabi, mapping = aes(Duration), bins = 100) +
  labs(title = "Histogram Time Duration of all Rides (before cleaning)", subtitle = "in seconds")
plt4

plt5 <- ggplot() +
  geom_freqpoly(data = cabi.sub, mapping = aes(Duration), bins = 100) +
  labs(title = "Histogram Time Duration of all Rides (after cleaning)", subtitle = "in seconds")
plt5

######################
### Parallel graph ####
#######################

df1 <- data.frame("StartOrEnd" = c("TopStartStations", "TopStartStations", "TopStartStations", "TopStartStations", "TopStartStations",
                                   "TopStartStations", "TopStartStations", "TopStartStations", "TopStartStations", "TopStartStations",
                                   "TopEndStations", "TopEndStations", "TopEndStations", "TopEndStations", "TopEndStations",
                                   "TopEndStations", "TopEndStations", "TopEndStations", "TopEndStations", "TopEndStations"),
                  "StationNames" = c("Columbus Circle / Union Station",
                                     "Lincoln Memorial",
                                     "Jefferson Dr & 14th St SW",
                                     "Massachusetts Ave & Dupont Circle NW",
                                     "Smithsonian-National Mall / Jefferson Dr & 12th St SW",
                                     "Henry Bacon Dr & Lincoln Memorial Circle NW",
                                     "15th & P St NW",
                                     "4th St & Madison Dr NW",
                                     "Jefferson Memorial",
                                     "Eastern Market Metro / Pennsylvania Ave & 7th St SE",
                                     "Columbus Circle / Union Station",
                                     "Lincoln Memorial",
                                     "Jefferson Dr & 14th St SW",
                                     "Massachusetts Ave & Dupont Circle NW",
                                     "15th & P St NW",
                                     "Smithsonian-National Mall / Jefferson Dr & 12th St SW",
                                     "Jefferson Memorial",
                                     "Henry Bacon Dr & Lincoln Memorial Circle NW",
                                     "4th St & Madison Dr NW",
                                     "14th & V St NW"),
                  "Usage" = c(119637, 112506, 96689, 77487, 75845, 74997, 74391, 73177, 73159, 56972,
                              126661, 113550, 99955, 85166, 78766, 78221, 75438, 75259, 73534, 60822))

plt1 <- ggplot(data = df1, aes(x = StartOrEnd, y = Usage, group = StationNames)) +
  geom_line(aes(color = StationNames, alpha = 1), size = 2) +
  geom_point(aes(color = StationNames, alpha = 1), size = 4) +
  geom_text(data = df1 %>% filter(StartOrEnd == "TopStartStations"), 
            aes(label = paste0(StationNames, " - ", Usage)) , 
            hjust = 1.05, 
            fontface = "bold", 
            size = 4) +
  geom_text(data = df1 %>% filter(StartOrEnd == "TopEndStations"), 
            aes(label = paste0(Usage, " - ", StationNames)) , 
            hjust = -.05, 
            fontface = "bold", 
            size = 4) +
  # move the x axis labels up top
  scale_x_discrete(position = "top", limits = rev(levels(df1$StartOrEnd)), expand=c(2, 2)) +
  theme_bw() +
  # Remove the legend
  theme(legend.position = "none") +
  # Remove the panel border
  theme(panel.border = element_blank()) +
  # Remove just about everything from the y axis
  theme(axis.title.y = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(panel.grid.major.y = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  # Remove a few things from the x axis and increase font size
  theme(axis.title.x = element_blank()) +
  theme(panel.grid.major.x = element_blank()) +
  theme(axis.text.x.top = element_text(size=12)) +
  # Remove x & y tick marks
  theme(axis.ticks = element_blank()) +
  # Format title & subtitle
  theme(plot.title = element_text(size=14, face = "bold", hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5)) +
  #  Labelling as desired
  labs(
    title = "Top 10 Start and End Stations Usage",
    subtitle = "from Jan 2017 to Sep 2018"
  )
plt1

###########################
## Rose Diagram #######
##########################

merged_cp1 <- read.csv("merged_cp1.csv")
mydf = merged_cp1
subdf <-mydf[,c(1,2,3)]

rose_long <- melt(subdf,id.vars="start_location",variable.name="location_type",value.name="number_of_bikes")

p <- ggplot(rose_long,position = "stack",aes(x=start_location, y=log(number_of_bikes), fill=location_type))+
  geom_bar(stat="identity", color="black")
p+coord_polar()+scale_fill_brewer(palette="Pinks")+labs(title = "Do Riders Travel Between Cities?",
                                                        y = "log(Usage)",
                                                        x = "Cities")

#limits=c("Alexandria","Arlington","Vienna","Fort Myer","Mc Lean","Reston","Washington","Bethesda","Chevy Chase","Derwood","Hyattsville","Mount Rainier","Oxon Hill","Riverdale","Rockville","Silver Spring","Takoma Park","Upper Marlboro")