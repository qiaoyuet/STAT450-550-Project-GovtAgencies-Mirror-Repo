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
LTB <- read.csv("tax_LTB_all_tidy.csv") %>% column_to_rownames("X")
STB <- read.csv("tax_STB_all_tidy.csv") %>% column_to_rownames("X")
STB <- STB[,-c(29,31)]

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
STB_ratio <- read.csv("tax_STB_ratio_tidy.csv") %>% column_to_rownames("X")
LTB_ratio <- read.csv("tax_LTB_ratio_tidy.csv") %>% column_to_rownames("X")



server <- function(input, output){
  map_cluster <- reactive({
    
    if (input$STBLTB == "LTB") {
      if (input$TotalRatio == "Total Number of Staff") {
        if (input$NumCluster == "2") {
          k=2
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_LTB_all <- data.frame(Province=colnames(tax_LTB_year_tidy),province_cluster)
        cluster_tax_LTB_all$province_cluster <- as.factor(cluster_tax_LTB_all$province_cluster)
        
      } else if (input$TotalRatio == "Staff Ratio") {
        if (input$NumCluster == "2") {
          k=2
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_LTB_year_tidy <- LTB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
          W <- tax_LTB_year_tidy_nmf@fit@W
          H <- tax_LTB_year_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_LTB_all <- data.frame(Province=colnames(tax_LTB_year_tidy_nmf),province_cluster)
        cluster_tax_LTB_all$province_cluster <- as.factor(cluster_tax_LTB_all$province_cluster)
      }
      cnmap %>% plyr::join(cluster_tax_LTB_all, by = "Province")
      
    } else if (input$STBLTB == "STB") {
      
      if (input$TotalRatio == "Total Number of Staff") {
        if (input$NumCluster == "2") {
          k=2
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_STB_all <- data.frame(Province=colnames(tax_STB_year_tidy),province_cluster)
        cluster_tax_STB_all$province_cluster <- as.factor(cluster_tax_STB_all$province_cluster)
      } else if (input$TotalRatio == "Staff Ratio") {
        if (input$NumCluster == "2") {
          k=2
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "3") {
          k=3
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        } else if (input$NumCluster == "4") {
          k=4
          YearSelect <- c(input$yearInput[1]:input$yearInput[2])
          tax_STB_year_tidy <- STB_ratio %>% 
            rownames_to_column('Year') %>% 
            filter(Year %in% YearSelect) %>%
            column_to_rownames('Year')
          tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
          W <- tax_STB_year_tidy_nmf@fit@W
          H <- tax_STB_year_tidy_nmf@fit@H
        }
        province_cluster <- rep(NA, ncol(H))
        for (i in 1:ncol(H)) {
          province_cluster[i] <- which(H[,i]==max(H[,i]))
        }
        cluster_tax_STB_all <- data.frame(Province=colnames(tax_STB_year_tidy),province_cluster)
        cluster_tax_STB_all$province_cluster <- as.factor(cluster_tax_STB_all$province_cluster)
      }
      cnmap %>% plyr::join(cluster_tax_STB_all, by = "Province") 
    }
  })
  MapInput <- reactive({
    ggplot(map_cluster())+ aes(x = long, y = lat, group = group, fill = province_cluster)   +
      geom_polygon(color = "grey") +
      scale_fill_brewer(name="Province Cluster",
                        palette="Spectral") +
      labs(x = "Longitude",
           y = "Latitude") +
      ggtitle('Clustering Map for Chinese Government Agency')
  })
  
  output$MapPlot <- renderPlot({
    print(MapInput())
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
      paste("We found ",n1," provinces in cluster 1, ",n2," provinces in cluster 2, ",n3, " provinces in cluster 3.")

    }else if (length(levels(map_cluster$Group.1))==4){
      n1 <- freqt$freq[1]
      n2 <- freqt$freq[2]
      n3 <- freqt$freq[3]
      n4 <- freqt$freq[4]
      paste("We found ",n1," provinces in cluster 1, ",n2," provinces in cluster 2, ",n3," provinces in cluster 3, ",
            n4," provinces in cluster 4.")

    }
    
  })
  
  output$num_results2 <- renderPrint({
    map_cluster <- map_cluster()
    map_cluster <- aggregate(x = map_cluster$long,FUN=sum,by = list(map_cluster$province_cluster,map_cluster$Province))
    if (length(levels(map_cluster$Group.1))==2){
      map_cluster$Group.1 <- as.character(map_cluster$Group.1)
      map_cluster$Group.2 <- as.character(map_cluster$Group.2)
      c1 <- map_cluster$Group.2[which(map_cluster$Group.1==1)]
      c2 <- map_cluster$Group.2[which(map_cluster$Group.1==2)]
      tmp1 <- paste(c1, collapse = ",")
      tmp2 <- paste(c2, collapse = ",")
      p1 <- cat("Cluster 1 has the following provinces: ",tmp1, sep = "\n")
      blank <- cat("-------------------------------------------", sep = "\n")
      p2 <- cat("Cluster 2 has the following provinces: ",tmp2, sep = "\n")
      cat(p1, blank,p2, sep = "\n")
      
    }else if (length(levels(map_cluster$Group.1))==3){
      map_cluster$Group.1 <- as.character(map_cluster$Group.1)
      map_cluster$Group.2 <- as.character(map_cluster$Group.2)
      c1 <- map_cluster$Group.2[which(map_cluster$Group.1==1)]
      c2 <- map_cluster$Group.2[which(map_cluster$Group.1==2)]
      c3 <- map_cluster$Group.2[which(map_cluster$Group.1==3)]
      tmp1 <- paste(c1, collapse = ",")
      tmp2 <- paste(c2, collapse = ",")
      tmp3 <- paste(c3, collapse = ",")
      blank <- "------------------------"
      p1 <- cat("Cluster 1 has the following provinces: ",tmp1, sep = "\n")
      blank1 <- cat("-------------------------------------------", sep = "\n")
      p2 <- cat("Cluster 2 has the following provinces: ",tmp2, sep = "\n")
      blank2 <- cat("-------------------------------------------", sep = "\n")
      p3 <- cat("Cluster 3 has the following provinces: ",tmp3, sep = "\n")
      cat(p1,blank1,p2,blank2,p3,sep = "\n")
      
    }else if (length(levels(map_cluster$Group.1))==4){
      map_cluster$Group.1 <- as.character(map_cluster$Group.1)
      map_cluster$Group.2 <- as.character(map_cluster$Group.2)
      c1 <- map_cluster$Group.2[which(map_cluster$Group.1==1)]
      c2 <- map_cluster$Group.2[which(map_cluster$Group.1==2)]
      c3 <- map_cluster$Group.2[which(map_cluster$Group.1==3)]
      c4 <- map_cluster$Group.2[which(map_cluster$Group.1==4)]
      tmp1 <- paste(c1, collapse = ",")
      tmp2 <- paste(c2, collapse = ",")
      tmp3 <- paste(c3, collapse = ",")
      tmp4 <- paste(c3, collapse = ",")
      p1 <- cat("Cluster 1 has the following provinces: ",tmp1, sep = "\n")
      blank1 <- cat("-------------------------------------------", sep = "\n")
      p2 <- cat("Cluster 2 has the following provinces: ",tmp2, sep = "\n")
      blank2 <- cat("-------------------------------------------", sep = "\n")
      p3 <- cat("Cluster 3 has the following provinces: ",tmp3, sep = "\n")
      blank3 <- cat("-------------------------------------------", sep = "\n")
      p4 <- cat("Cluster 4 has the following provinces: ",tmp4, sep = "\n")
      cat(p1,blank1,p2,blank2,p3,blank3,p4,sep = "\n")
      
    }
  })
  
  output$readme <- renderUI({
HTML("This shiny app is designed for the STAT450/550 Project: Chinese Government Agencies. The project investigates the changes of staffing number in the Chinese Tax Bureau over 2000-2007. This shiny app provides a visualization of clusters of chinese provinces with similar patterns in either total staff number or staff number ratio given various choices of filters. The clustering is based on the Non-negative Matrix Factarization (NMF) method. It is important to note that NMF is not a classical clustering method and may not be able to give the exact number of clusters specified. If the actual number of clusters is less than the pre-specified number of clusters, it means the data are not significantly different enough to be seperated into more clusters."
  )})
  
}
