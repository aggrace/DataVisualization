#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

data_raw=read.csv("data/reduced_beijing.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    price=data_raw$price
    bins=seq(min(price),max(price),length.out=input$bins +1)
    
    return(hist(price, breaks = bins, col = '#75AADB', border = 'white', main = "housing price over time "))
    # draw the histogram with the specified number of bins
  })
  
})

