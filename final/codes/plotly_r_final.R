data_raw=read.csv("~/Desktop/reduced_beijing.csv")
data_raw=read.csv("~/Desktop/reduced_beijing.csv")
head(data_raw,30)
Sys.setenv("plotly_username"="aggrace")
Sys.setenv("plotly_api_key"="7QA8vCCuskfTnuxJpfQL")

library(plotly)
p=plot_ly(data_raw,y=~price,color=~floor,type="box") %>%
  layout(
    title="The relation between floor type and price of each floor type",
    scene=list(xaxis="The floor of housing in Beijing",
               yaxis="price of each floor type")
  )

p

api_create(p, filename = "final plotly in r")
