library(tidyverse)
library(DT)
library(stringr)
library(maptools)
library(shinyjs)
library(shiny)

# Define UI for the app

ui <- fluidPage(
  titlePanel(p(strong("GovtAgencies"))),
  hr(),
  sidebarPanel(p(strong("Filters")),
               br(),br(),
               sliderInput("yearInput", "Year", min = 2000, max = 2007, c(2000, 2007)),
               br(),
               radioButtons("STBLTB", "STB or LTB?", choices = c("STB", "LTB"), selected = "LTB"),
               br(),
               selectInput("NumCluster", "Number of Clusters", choices = c("2","3","4"), multiple = F),
               br(),
               # selectInput("typeInAge", "Age Group",choices = c("age 30 or below", "30-35", "36-40","41-45",
               #                                                  "46-50","51-54","55-59","60 or above"),
               #             selected = "age 30 or below",multiple = TRUE),
               # br(),
               # selectInput("typeInEdu", "Education Level",choices = c("PostGraduate", "Bachelors", "OtherPostSecondary",
               #                                                        "TechnicalCollege","HighSchool","JuniorHigh"),
               #             selected = NULL,multiple = TRUE),
               # br(),
               # selectInput("typeInUnit", "Work Unit",choices = c("Admin", "Business","DAE Admin","DAE NonAdmin","Tax"),
               #             selected = NULL,multiple = TRUE),
               submitButton("Search"),
               textOutput("num_results")),
  
  mainPanel(tabsetPanel(
    tabPanel("Map of China",
             br(),
             plotOutput("MapPlot")),
    tabPanel("Results Table",
             br(),
             downloadLink('DataDownload', 'Download the results table here'),
             br(),
             DT::dataTableOutput("table_head"))))
)