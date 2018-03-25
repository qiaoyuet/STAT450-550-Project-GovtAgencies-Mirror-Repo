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
LTB <- read.csv("tax_LTB_all_tidy.csv")
STB <- read.csv("tax_STB_all_tidy.csv")
STB <- STB[,-c(1,31,29)]
LTB <- LTB[,-1]
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
LTB$Hebei <- as.numeric(as.character(LTB$Hebei))
LTB$Hebei[2] <- 21520
#rownames(STB) <- c("2000","2001","2002","2003","2004","2005","2006","2007")
#rownames(LTB) <- c("2000","2001","2002","2003","2004","2005","2006","2007")
STB_ratio <- read.csv("tax_STB_ratio_tidy.csv")
LTB_ratio <- read.csv("tax_LTB_ratio_tidy.csv")


server <- function(input, output){
  map_cluster <- reactive({
    
    if (input$STBLTB == "LTB") {
      
      if (input$TotalRatio == "Total Number of Staff") {
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
        
      } else if (input$TotalRatio == "Staff Ratio") {
        if (input$NumCluster == "2") {
          k=2
          tax_LTB_all_tidy_nmf <- nmf(LTB_ratio, rank = k)
          W <- tax_LTB_all_tidy_nmf@fit@W
          H <- tax_LTB_all_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          tax_LTB_all_tidy_nmf <- nmf(LTB_ratio, rank = k)
          W <- tax_LTB_all_tidy_nmf@fit@W
          H <- tax_LTB_all_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          tax_LTB_all_tidy_nmf <- nmf(LTB_ratio, rank = k)
          W <- tax_LTB_all_tidy_nmf@fit@W
          H <- tax_LTB_all_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_LTB_all <- data.frame(Province=colnames(LTB_ratio),province_cluster)
        cluster_tax_LTB_all$province_cluster <- as.factor(cluster_tax_LTB_all$province_cluster)
      }
      cnmap %>% plyr::join(cluster_tax_LTB_all, by = "Province")
      
    } else if (input$STBLTB == "STB") {
      
      if (input$TotalRatio == "Total Number of Staff") {
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
      } else if (input$TotalRatio == "Staff Ratio") {
        if (input$NumCluster == "2") {
          k=2
          tax_STB_all_tidy_nmf <- nmf(STB_ratio, rank = k)
          W <- tax_STB_all_tidy_nmf@fit@W
          H <- tax_STB_all_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          tax_STB_all_tidy_nmf <- nmf(STB_ratio, rank = k)
          W <- tax_STB_all_tidy_nmf@fit@W
          H <- tax_STB_all_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          tax_STB_all_tidy_nmf <- nmf(STB_ratio, rank = k)
          W <- tax_STB_all_tidy_nmf@fit@W
          H <- tax_STB_all_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_STB_all <- data.frame(Province=colnames(STB_ratio),province_cluster)
        cluster_tax_STB_all$province_cluster <- as.factor(cluster_tax_STB_all$province_cluster)
      }
      cnmap %>% plyr::join(cluster_tax_STB_all, by = "Province") 
    }
  })
  output$MapPlot <- renderPlot({
      ggplot(map_cluster()) +aes(x = long, y = lat, group = group, fill = province_cluster)+
      geom_polygon(color = "grey")
  })
  
  output$num_results <- renderText({
    map_cluster <- map_cluster()
    map_cluster <- aggregate(x = map_cluster$long,FUN=sum,by = list(map_cluster$province_cluster,map_cluster$Province))
    freqt <- as.data.frame(summary(map_cluster$Group.1))
    names(freqt)[1] <- "freq"
    if (length(levels(map_cluster$Group.1))==2){
      n1 <- freqt$freq[1]
      n2 <- freqt$freq[2]
      paste("We found ",n1," provinces in cluster 1, ",n2," provinces in cluster 2.")
    }else if (length(levels(map_cluster$Group.1))==3){
      n1 <- freqt$freq[1]
      n2 <- freqt$freq[2]
      n3 <- freqt$freq[3]
      paste("We found ",n1," provinces in cluster 1, ",n2," provinces in cluster 2, ",n3," provinces in cluster 3.")
    }else if (length(levels(map_cluster$Group.1))==4){
      n1 <- freqt$freq[1]
      n2 <- freqt$freq[2]
      n3 <- freqt$freq[3]
      n4 <- freqt$freq[4]
      paste("We found ",n1," provinces in cluster 1, ",n2," provinces in cluster 2, ",n3," provinces in cluster 3, ",
            n4," provinces in cluster 4.")
    }
  })
  
#  output$MapDownload<-downloadHandler(
#    filename = function() {
#      paste('colored map.pdf')
#    },
#    content = function(file) {
#      write.pdf()
#    })
}