#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

o_bs <- read.csv("data/n_station.csv")
s_bs <- read.csv("data/s_station.csv")


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bike Share Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      hr(),
      helpText("Bike Share data from GOV")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      plotOutput("distPlot_2")
    )
  )
))
