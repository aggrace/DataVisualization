install.packages("devtools")
library("devtools")
install_github("Rforecastio", "hrbrmstr")

library(Rforecastio)
library(ggplot2)
devtools::install_github("hrbrmstr/darksky", force = TRUE)
library(darksky)
library(tidyverse)
date <- read.csv('~/Desktop/2018_hourly_reference.csv')
date$DATE <- as.character(date$DATE)

list1 <- c()
list2 <- c()
for(i in 1:length(date$DATE)){
  if(as.integer(substring(date$DATE[i],12,13))!=0){
    list1= append(list1, i)
  }
  else if(as.integer(substring(date$DATE[i],15,16))!=0){
    list2 = append(list2,i)
  }
}
as.integer(substring(date$DATE[3],12,13))


list3 <- append(list1, list2)
list3
date <- date[-list3,]
datelist <- date$DATE

Sys.setenv(DARKSKY_API_KEY ="c369a6da63c6e3afa4e490d1a666968b")

hourly <- data.frame()
daily <- data.frame()
for(i in 1:length(datelist)){
  then <- get_forecast_for(38.9072, -77.0369, datelist[i], add_headers=TRUE)
  hourly <- bind_rows(hourly,then$hourly)
  daily <- bind_rows(daily, then$daily)
}

write.csv(hourly, "~/Desktop/hourly.csv")
write.csv(daily, "~/Desktop/daily.csv")


print(sprintf("You have used %s API calls.", then$`x-forecast-api-calls`))


write.csv(date, "~/Desktop/list.csv")
list4 <- read.csv("~/Desktop/list.csv")
list4$DATE <- as.character(list4$DATE)
hourly1 <- data.frame()
daily1 <- data.frame()
for(i in 1:length(list4$DATE)){
  then <- get_forecast_for(38.9072, -77.0369, list4$DATE[i], add_headers=TRUE)
  hourly1 <- bind_rows(hourly1,then$hourly)
  daily1 <- bind_rows(daily1, then$daily)
}
write.csv(hourly1, "~/Desktop/hourly1.csv")
write.csv(daily1, "~/Desktop/daily1.csv")

View(list4)
length(list4$DATE)

hourly2 <- data.frame()
for(i in 1:101){
  then <- get_forecast_for(38.9072, -77.0369, list4$DATE[i], add_headers=TRUE)
  hourly2 <- rbind(hourly2,then$hourly)
}
write.csv(hourly2, "~/Desktop/hourly2.csv")

hourly <- read.csv("~/Desktop/2018_extraction_hourly.csv")
hourly1 <- read.csv("~/Desktop/hourly1.csv")
hourly2 <- read.csv("~/Desktop/hourly2.csv")

weather <- bind_rows(hourly, hourly1)
daily_weather <- bind_rows(daily, daily1)

write.csv(weather, "~/Desktop/weather_hourly_2017-2018.csv")
write.csv(daily_weather, "~/Desktop/weather_daily_2017-2018.csv")


summary(weather)
weather$icon <- as.factor(weather$icon)
weather$summary <- as.factor(weather$summary)

daily_weather$icon <- as.factor(daily_weather$icon)



write.csv(hourly, '~/Desktop/hourly_2018.csv')
write.csv(hourly1, '~/Desktop/hourly_2017.csv')
write.csv(daily, '~/Desktop/daily_2018.csv')
write.csv(daily1, '~/Desktop/daily_2017.csv')







whourly = read.csv("~/Desktop/weather_hourly_2017-2018.csv")
wdaily = read.csv("~/Desktop/weather_daily_2017-2018.csv")

hourly1 <- read.csv('~/Desktop/hourly_2017.csv')
hourly2 <- read.csv('~/Desktop/hourly_2018.csv')

whourly <- bind_rows(hourly1,hourly2)
###################visibility
hist(whourly$visibility)
vis_na<-subset(whourly,is.na(whourly$visibility)) 
apply(whourly, 2, function(x) any(is.na(x)))
sub <- whourly[whourly$summary=='Partly Cloudy',]

mean(sub$visibility, na.rm = TRUE)

whourly$visibility[is.na(whourly$visibility)] = mean(sub$visibility, na.rm = TRUE)
is.na(whourly$visibility)


hist(whourly$visibility)

ggplot(whourly, aes(x=visibility)) + geom_histogram()+ggtitle("visibility hourly distribution washington dc 2017-2018")+theme(plot.title = element_text(hjust = 0.5))


write.csv(whourly, '~/Desktop/hourly.csv')
hourly <- read.csv('~/Desktop/hourly.csv')
apply(hourly, 2, function(x) any(is.na(x)))
#####################

apply(whourly, 2, function(x) any(is.na(x)))


library(reshape2)
library(ggplot2)


#Let’s test it out
library(dplyr)
library(wakefield)
library(Amelia)
ggplot_missing(whourly)

missmap(wdaily)
wdaily <- wdaily[,(1:37)]
missmap(wdaily)
aaa <- whourly[,c('windGust','visibility')]

wind_na<-subset(whourly,is.na(whourly$windGust)) 
#list <- which(is.na(whourly$windGust), arr.ind=TRUE)
ind <- which(is.na(whourly$windGust))
whourly$windGust[ind] <- sapply(ind, function(i) with(whourly, mean(c(windGust[i-1], windGust[i+1]))))

ind <- which(is.na(whourly$windGust))
whourly$windGust[ind] <- sapply(ind, function(i) with(whourly, mean(c(windGust[i-2], windGust[i+2]))))
#df
ind

whourly <- whourly[,c(1:17)]
missmap(whourly)

ggplot(whourly, aes(x=windGust)) + geom_histogram()+ggtitle("windGust hourly distribution washington dc 2017-2018")+theme(plot.title = element_text(hjust = 0.5))

ggplot(whourly, aes(x=windGust)) + geom_histogram()+ggtitle("windGust hourly distribution washington dc 2017-2018")+theme(plot.title = element_text(hjust = 0.5))




