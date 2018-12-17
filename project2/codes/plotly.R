setwd("D:/Courses/ANLY 503/Project/Project2")
## read dataset
cabi <- read.csv("capital17-18_reduced.csv")
#cabi <- read.csv("capital17-18_reduced.csv", colClasses = c("numeric", rep("POSIXlt", 2), rep("factor", 4)))
cabiloc <- read.csv("Capital Bikeshare Locations Clean.csv")

## clean data
## Add day.of.week column
cabi <- subset(cabi, select = -c(End.date, Start.station.number, End.station.number, Bike.number, Member.type))
cabi$day.of.week <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")[as.POSIXlt(cabi$Start.date)$wday + 1]
i1 <- which(cabi$day.of.week == "Monday")
i2 <- which(cabi$day.of.week == "Tuesday")
i3 <- which(cabi$day.of.week == "Wednesday")
i4 <- which(cabi$day.of.week == "Thursday")
i5 <- which(cabi$day.of.week == "Friday")
i6 <- which(cabi$day.of.week == "Saturday")
i7 <- which(cabi$day.of.week == "Sunday")
cabi1 <- cabi[i1,]
cabi1$hour <- as.POSIXct(paste0("2001-01-01", substr(cabi1$Start.date, 11, 14), "00:00"))
cabi2 <- cabi[i2,]
cabi2$hour <- as.POSIXct(paste0("2001-01-02", substr(cabi2$Start.date, 11, 14), "00:00"))
cabi3 <- cabi[i3,]
cabi3$hour <- as.POSIXct(paste0("2001-01-03", substr(cabi3$Start.date, 11, 14), "00:00"))
cabi4 <- cabi[i4,]
cabi4$hour <- as.POSIXct(paste0("2001-01-04", substr(cabi4$Start.date, 11, 14), "00:00"))
cabi5 <- cabi[i5,]
cabi5$hour <- as.POSIXct(paste0("2001-01-05", substr(cabi5$Start.date, 11, 14), "00:00"))
cabi6 <- cabi[i6,]
cabi6$hour <- as.POSIXct(paste0("2001-01-06", substr(cabi6$Start.date, 11, 14), "00:00"))
cabi7 <- cabi[i7,]
cabi7$hour <- as.POSIXct(paste0("2001-01-07", substr(cabi7$Start.date, 11, 14), "00:00"))
cabi <- rbind(cabi1, cabi2, cabi3, cabi4, cabi5, cabi6, cabi7)
rm(cabi1, cabi2, cabi3, cabi4, cabi5, cabi6, cabi7, i1, i2, i3, i4, i5, i6, i7)

## bin data by day.of.week and hour
library(plyr)
df1 <- ddply(cabi, .(cabi$day.of.week, cabi$hour), nrow)
names(df1) <- c("day.of.week", "hour", "count")
df2 <- aggregate(cabi$Duration, by = list(cabi$day.of.week, cabi$hour), mean)
names(df2) <- c("day.of.week", "hour", "average.duration")
df <- merge(df2, df1, all = TRUE)

## plotly
library(plotly)

Sys.setenv("plotly_username"="liyigao")
Sys.setenv("plotly_api_key"="6EmMOoSuy5cfO0f6PLyK")

aval = list()
for (s in c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")){
  aval[[s]] <- list(visible = FALSE,
                    name = s,
                    x = df$hour[df$day.of.week == s],
                    y1 = df$count[df$day.of.week == s],
                    y2 = df$average.duration[df$day.of.week == s])
}
aval$Sunday$visible <- TRUE

steps <- list()
p <- plot_ly()
p1 <- plot_ly()
p2 <- plot_ly()

for (i in 1:7){
  p1 <- add_trace(p1, x = aval[i][[1]]$x, y = aval[i][[1]]$y1, visible = aval[i][[1]]$visible, name = aval[i][[1]]$name,
                  mode = "lines+markers", hoverinfo = "y", showlegend = FALSE)
  p2 <- add_trace(p2, x = aval[i][[1]]$x, y = aval[i][[1]]$y2, visible = aval[i][[1]]$visible, name = aval[i][[1]]$name,
                  mode = "lines+markers", hoverinfo = "y", showlegend = FALSE)
  p <- subplot(p1, p2, nrows = 2, shareX = TRUE, titleY = TRUE)
  s <- list(args = list("visible", rep(FALSE, length(aval))),
            method = "restyle",
            label = i)
  s$args[[2]][i] = TRUE
  steps[[i]] = s
}
steps[[1]]$label <- "Sunday"
steps[[2]]$label <- "Monday"
steps[[3]]$label <- "Tuesday"
steps[[4]]$label <- "Wednesday"
steps[[5]]$label <- "Thursday"
steps[[6]]$label <- "Friday"
steps[[7]]$label <- "Saturday"

p <- p %>%
  layout(title = "Capital Bikeshare Hourly Usage and Duration(in seconds) per ride",
         xaxis = list(title = "Time"),
         yaxis = list(range = c(500, 123000), title = "Usage"),
         yaxis2 = list(range = c(670, 1830), title = "Average Duration"),
         sliders = list(list(active = 0,
                             currentvalue = list(prefix = "Day of Week: "),
                             steps = steps)))

p

#api_create(p, filename = "503project slider daily")

rm(df, df1, df2, aval, i, p, p1, p2, s, steps)

####################################################################

## clean data
rm(cabi)
cabi <- read.csv("capital17-18_reduced.csv")
cabi <- subset(cabi, select = -c(End.date, Start.station.number, End.station.number, Bike.number, Member.type))
cabi$Start.date <- substr(cabi$Start.date, 1, 10)
df1 <- data.frame(table(cabi$Start.date))
df2 <- aggregate(cabi$Duration, by = list(cabi$Start.date), mean)
colnames(df1) <- c("date", "count")
colnames(df2) <- c("date", "average.duration")
df <- merge(df2, df1, all = TRUE)
df$date <- as.POSIXct(df$date)
rm(df1, df2)

## plotly
rm(p, p1, p2)
p <- plot_ly()
p1 <- plot_ly()
p2 <- plot_ly()
p1 <- add_trace(p1, x = df$date, y = df$count, type = "scatter", mode = "lines+markers", hoverinfo = "x", showlegend = FALSE)
p2 <- add_trace(p2, x = df$date, y = df$average.duration, type = "scatter", mode = "lines+markers", hoverinfo = "x", showlegend = FALSE)
p <- subplot(p1, p2, nrows = 2, shareX = TRUE, titleY = TRUE)
p <- p %>%
  layout(
    title = "Capital Bikeshare Daily Usage and Duration(in seconds) per ride",
    xaxis = list(
      rangeselector = list(buttons = list(
        list(
          count = 1,
          label = "1 wk",
          step = "week",
          stepmode = "backward"
        ),
        list(
          count = 1,
          label = "1 mo",
          step = "month",
          stepmode = "backward"
        ),
        list(
          count = 3,
          label = "3 mo",
          step = "month",
          stepmode = "backward"
        ),
        list(
          count = 6,
          label = "6 mo",
          step = "month",
          stepmode = "backward"
        ),
        list(
          count = 9,
          label = "9 mo",
          step = "month",
          stepmode = "backward"
        ),
        list(
          count = 1,
          label = "1 yr",
          step = "year",
          stepmode = "backward"
        ),
        list(
          count = 1,
          label = "YTD",
          step = "year",
          stepmode = "todate"
        ),
        list(step = "all")
      )),
      rangeslider = list(type = "date")
    ),
    yaxis = list(range = c(1000, 20000), title = "Usage"),
    yaxis2 = list(range = c(500, 2100), title = "Average Duration")
  )

p

api_create(p, filename = "503project slider hourly")
