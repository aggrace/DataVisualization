#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

o_bs <- read.csv("data/n_station.csv")
s_bs <- read.csv("data/s_station.csv")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    Duration <- s_bs$Duration
    bins <- seq(min(Duration), max(Duration), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    return(hist(Duration, breaks = bins, col = 'darkgray', border = 'white', main = "Bike Duration with the same start and end station"))
    
  })
  
  output$distPlot_2 <- renderPlot({
    # generate bins based on input$bins from ui.R
    Duration <- o_bs$Duration
    bins <- seq(min(Duration), max(Duration), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    return(hist(Duration, breaks = bins, col = 'darkgray', border = 'white', main = "Bike Duration with the different start and end station"))
    
  })
  
})
