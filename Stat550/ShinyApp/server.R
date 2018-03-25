library(tidyverse)
library(DT)
library(stringr)
library(maptools)
library(ggplot2)
library(shinyjs)
library(shiny)
library(NMF)

#STB <- read.csv("./Data/nmf_data/tax_LTB_all_tidy.csv")
#LTB <- read.csv("./Data/nmf_data/tax_STB_all_tidy.csv")
STB <- read.csv("tax_LTB_all_tidy.csv")
LTB <- read.csv("tax_STB_all_tidy.csv")
LTB <- LTB[,-c(1,31,29)]
STB <- STB[,-1]
#cnmap <- read.csv("./Data/CHN_adm1_data/cnmapdf.csv") %>% column_to_rownames("X")
cnmap <- read.csv("cnmapdf.csv") %>% column_to_rownames("X")
colnames(cnmap)[8] <- "Province"
levels(cnmap$Province)[levels(cnmap$Province)=="Inner Mongolia"] <- "Inner.Mongolia"
#LTB$Chongqing[1] <- min(LTB$Chongqing, na.rm = T)
#STB$Chongqing[9] <- min(STB$Chongqing, na.rm = T)
#STB <- select(STB,-Yangzhou)
STB <- STB[complete.cases(STB), ]
LTB <- LTB[complete.cases(LTB), ]
cnmap <- cnmap[complete.cases(cnmap), ]
#rownames(STB) <- c("2000","2001","2002","2003","2004","2005","2006","2007")
#rownames(LTB) <- c("2000","2001","2002","2003","2004","2005","2006","2007")

server <- function(input, output){
  
  output$MapPlot <- renderPlot({

    if (input$STBLTB == "LTB") {
      
      if (input$NumCluster == "2") {
        k=2
        tax_LTB_all_tidy_nmf <- nmf(LTB, rank = k)
        W <- tax_LTB_all_tidy_nmf@fit@W
        H <- tax_LTB_all_tidy_nmf@fit@H
      } else if (input$NumCluster == "3") {
        k=3
        tax_LTB_all_tidy_nmf <- nmf(LTB, rank = k)
        W <- tax_LTB_all_tidy_nmf@fit@W
        H <- tax_LTB_all_tidy_nmf@fit@H
      } else if (input$NumCluster == "4") {
        k=4
        tax_LTB_all_tidy_nmf <- nmf(LTB, rank = k)
        W <- tax_LTB_all_tidy_nmf@fit@W
        H <- tax_LTB_all_tidy_nmf@fit@H
      }
      province_cluster <- rep(NA, ncol(H))
      for (i in 1:ncol(H)) {
        province_cluster[i] <- which(H[,i]==max(H[,i]))
      }
      cluster_tax_LTB_all <- data.frame(Province=colnames(LTB),province_cluster)
      cluster_tax_LTB_all$province_cluster <- as.factor(cluster_tax_LTB_all$province_cluster)
      
      map_cluster <- cnmap %>% plyr::join(cluster_tax_LTB_all, by = "Province")
      
      map_cluster %>%
        ggplot(aes(x = long, y = lat, group = group, fill = province_cluster)) +
        geom_polygon(color = "grey")
    } else if (input$STBLTB == "STB") {
      
      if (input$NumCluster == "2") {
        k=2
        tax_STB_all_tidy_nmf <- nmf(STB, rank = k)
        W <- tax_STB_all_tidy_nmf@fit@W
        H <- tax_STB_all_tidy_nmf@fit@H
      } else if (input$NumCluster == "3") {
        k=3
        tax_STB_all_tidy_nmf <- nmf(STB, rank = k)
        W <- tax_STB_all_tidy_nmf@fit@W
        H <- tax_STB_all_tidy_nmf@fit@H
      } else if (input$NumCluster == "4") {
        k=4
        tax_STB_all_tidy_nmf <- nmf(STB, rank = k)
        W <- tax_STB_all_tidy_nmf@fit@W
        H <- tax_STB_all_tidy_nmf@fit@H
      }
      province_cluster <- rep(NA, ncol(H))
      for (i in 1:ncol(H)) {
        province_cluster[i] <- which(H[,i]==max(H[,i]))
      }
      cluster_tax_STB_all <- data.frame(Province=colnames(STB),province_cluster)
      cluster_tax_STB_all$province_cluster <- as.factor(cluster_tax_STB_all$province_cluster)
      
      map_cluster <- cnmap %>% 
        plyr::join(cluster_tax_STB_all, by = "Province") 
      map_cluster %>%
        ggplot(aes(x = long, y = lat, group = group, fill = province_cluster)) +
        geom_polygon(color = "grey")
    }

  })
  
  

#  filtered_pro <- reactive()
#  output$num_results <- renderText({ 
#    n<-nrow()
#    paste("We filtered out",n,"provinces")
#  })
#  output$MapPlot <- renderPlot()
#  output$table_head <- DT::renderDataTable()
#  output$DataDownload <- downloadHandler()
}