library(tidyverse)
library(DT)
library(stringr)
library(maptools)
library(ggplot2)
library(shinyjs)
library(shiny)

server <- function(input, output){
  mapdata <- read.csv("cnmapdf.csv")
#  output$num_results <- renderText({ 
#    n<-nrow()
#    paste("We filtered out",n,"provinces")
#  })
#  output$MapPlot <- renderPlot()
#  output$table_head <- DT::renderDataTable()
#  output$DataDownload <- downloadHandler()
}