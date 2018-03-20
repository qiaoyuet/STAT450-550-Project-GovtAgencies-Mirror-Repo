library(tidyverse)
library(DT)
library(stringr)
library(shinyjs)
library(shiny)

# Define UI for the app

ui <- fluidPage(
  titlePanel(p(strong("GovtAgencies"))),
  hr(),
  sidebarPanel(p(strong("Filters")),
               br(),br(),
               selectInput("typeIn", "Filter type",choices = c("AGE", "EDUCATION", "UNIT"),
                           selected = "WINE",multiple = TRUE),
               submitButton("Search")),
  mainPanel(tabsetPanel(
    tabPanel("Map of China",
             br()),
    tabPanel("Results Table",
             br(),
             downloadLink('DataDownload', 'Download the results table here'),
             br(),
             DT::dataTableOutput("table_head"))))
)