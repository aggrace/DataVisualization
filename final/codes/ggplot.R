library(ggplot2)

##Section 1. Data Preprocessing
#############1.1loading data

data=read.csv(file="~/Desktop/beijing.csv",
              header = TRUE, sep = ",",
              na.strings = c("nan","#NAME?"),
              fileEncoding="gbk")

#############1.2 Converting some chinese characters into English
data$floor = gsub("高", "high", data$floor)
data$floor = gsub("低", "low", data$floor)
data$floor = gsub("中", "mid", data$floor)
data$floor = gsub("底", "bottom", data$floor)
data$floor = gsub("顶", "low", data$floor)
data$floor = gsub("未知", "unkown", data$floor)
data$floor = gsub("钢混结构", "steel-concrete composite", data$floor)
data$floor = gsub("混合结构", "mixed", data$floor)
data$drawingRoom = gsub("中", "mid", data$drawingRoom)
data$drawingRoom = gsub("高", "high", data$drawingRoom)
data$drawingRoom = gsub("低", "low", data$drawingRoom)
data$drawingRoom = gsub("底", "bottom", data$drawingRoom)
data$drawingRoom = gsub("顶", "top", data$drawingRoom)
data$constructionTime = gsub("未知", NA, data$constructionTime)
data$bathRoom = gsub("未知", NA, data$bathRoom)
data$Cid = as.factor(data$Cid)

write.csv(data,file='beijing2.csv')

## Section 2 Creating visualizations
############2.1 at least three static ggplot2 with 3 layers
library(ggplot2)

data %>% ggplot(aes(x=Lng,y=Lat))+
  geom_point(aes(color=price),size=0.1,alpha=0.5)+ 
  scale_colour_gradientn(colors = viridis::viridis(100)) + theme_minimal() + 
  theme(legend.position = 'bottom') + 
  guides(color = guide_colorbar(barwidth = 35, barheight = .75))+
  ggtitle('How does housing prices distributed by latitude and longtitude in Beijing')


p1=ggplot(data)+
  geom_histogram(aes(x=price,fill=constructionTime))+
  geom_smooth(mapping=aes(x=price,y=communityAverage))+
  ggtitle('histogram and smooth line about price and Beijing housing')

p2=ggplot(data,aes(price,communityAverage,colour=district)) +
  geom_point() +
  geom_smooth(se=FALSE,method=lm)+
  ggtitle('relationship between price and community average by different district')

p2

ggplot(data)+
#geom_point(mapping=aes(x=price,y=renovationCondition,color=buildingStructure))
geom_smooth(mapping=aes(x=price,y=renovationCondition))+
facet_wrap(~ renovationCondition, nrow=2) +
  geom_segment(aes(x=price, 
                   xend=price, 
                   y=min(renovationCondition), 
                   yend=max(renovationCondition)), 
               linetype="dashed",
               size=0.1,
               color="red") +
  ggtitle("Price and community average")
  

#############2.1 Plotly 

############ Set API keys once
Sys.setenv("plotly_username"="aggrace")
Sys.setenv("plotly_api_key"="A9i4LO5nF7ngYaMiL35H")

library(plotly)
p=plot_ly(data=data,
          x=~district,
          y=~totalPrice,
          type="scatter",
          mode="markers")
p

api_create(p,filename="scatter plot between district and total price")




