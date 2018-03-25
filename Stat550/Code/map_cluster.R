library(tidyverse)
library(NMF)
# Read data
cnmap <- read.csv("./Data/CHN_adm1_data/cnmapdf.csv") %>% column_to_rownames("X")
colnames(cnmap)[8] <- "Province"

tax_LTB_all_tidy <- read.csv("./Data/nmf_data/tax_LTB_all_tidy.csv") %>% column_to_rownames("X")
tax_LTB_all_tidy$Chongqing[1] <- min(tax_LTB_all_tidy$Chongqing, na.rm = T)

tax_STB_all_tidy <- read.csv("./Data/nmf_data/tax_STB_all_tidy.csv") %>% column_to_rownames("X")
tax_STB_all_tidy$Chongqing[9] <- min(tax_STB_all_tidy$Chongqing, na.rm = T)
tax_STB_all_tidy <- select(tax_STB_all_tidy,-Yangzhou)
# Cluster for LTB
k=3
tax_LTB_all_tidy_nmf <- nmf(tax_LTB_all_tidy, rank = k)
W <- tax_LTB_all_tidy_nmf@fit@W
H <- tax_LTB_all_tidy_nmf@fit@H

province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
  province_cluster[i] <- which(H[,i]==max(H[,i]))
}
cluster_tax_LTB_all <- data.frame(Province=colnames(tax_LTB_all_tidy),province_cluster)
cluster_tax_LTB_all$province_cluster <- as.factor(cluster_tax_LTB_all$province_cluster)

map_cluster <- cnmap                                                  %>% 
  plyr::join(cluster_tax_LTB_all, by = "Province")  

pdf('Stat550/Figure/map_cluster_tax_LTB_all.pdf',width = 8,height = 6)
map_cluster                                                             %>%
    ggplot(aes(x = long, y = lat, group = group, fill = province_cluster))   +
    geom_polygon(color = "grey") +
    scale_fill_brewer(palette="Spectral",
                      name="Province Cluster",
                      labels=c("Cluster 1", "Cluster 2", "Cluster 3", "No Staffing Number")) +
    labs(x = "Longitude",
         y = "Latitude")+
    ggtitle('Clustering Map for Chinese Government Agency LTB')
dev.off()

# Cluster for STB
tax_STB_all_tidy_nmf <- nmf(tax_STB_all_tidy, rank = k)
W <- tax_STB_all_tidy_nmf@fit@W
H <- tax_STB_all_tidy_nmf@fit@H

province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
    province_cluster[i] <- which(H[,i]==max(H[,i]))
}
cluster_tax_STB_all <- data.frame(Province=colnames(tax_STB_all_tidy),province_cluster)
cluster_tax_STB_all$province_cluster <- as.factor(cluster_tax_STB_all$province_cluster)

map_cluster <- cnmap                                                  %>% 
    plyr::join(cluster_tax_STB_all, by = "Province")  

pdf('Stat550/Figure/map_cluster_tax_STB_all.pdf',width = 8,height = 6)
map_cluster                                                             %>%
    ggplot(aes(x = long, y = lat, group = group, fill = province_cluster)) +
    geom_polygon(color = "grey") +
    scale_fill_brewer(name="Province Cluster",
                      palette="Spectral",
                      labels=c("Cluster 1", "Cluster 2", "Cluster 3", "No Staffing Number")) +
    labs(x = "Longitude",
         y = "Latitude") +
    ggtitle('Clustering Map for Chinese Government Agency STB')

dev.off()

############################# Filter data by time ##############################

YearSelect <- c("2000":"2003")

tax_LTB_year_tidy <- tax_LTB_all_tidy %>% 
    rownames_to_column('Year') %>% 
    filter(Year %in% YearSelect) %>%
    column_to_rownames('Year')

tax_STB_year_tidy <- tax_STB_all_tidy %>% 
    rownames_to_column('Year') %>% 
    filter(Year %in% YearSelect) %>%
    column_to_rownames('Year')
    
############################# Cluster time data##############################

# Cluster for LTB
k=3
tax_LTB_year_tidy_nmf <- nmf(tax_LTB_year_tidy, rank = k)
W <- tax_LTB_year_tidy_nmf@fit@W
H <- tax_LTB_year_tidy_nmf@fit@H

province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
    province_cluster[i] <- which(H[,i]==max(H[,i]))
}
cluster_tax_LTB_year <- data.frame(Province=colnames(tax_LTB_year_tidy),province_cluster)
cluster_tax_LTB_year$province_cluster <- as.factor(cluster_tax_LTB_year$province_cluster)

map_cluster <- cnmap                                                  %>% 
    plyr::join(cluster_tax_LTB_year, by = "Province")  

pdf('Stat550/Figure/map_cluster_tax_LTB_year.pdf',width = 8,height = 6)
map_cluster                                                             %>%
    ggplot(aes(x = long, y = lat, group = group, fill = province_cluster))   +
    geom_polygon(color = "grey") +
    scale_fill_brewer(palette="Spectral",
                      name="Province Cluster",
                      labels=c("Cluster 1", "Cluster 2", "Cluster 3", "No Staffing Number")) +
    labs(x = "Longitude",
         y = "Latitude") +
    ggtitle('Clustering Map for Chinese Government Agency LTB')
dev.off()

# Cluster for STB
tax_STB_year_tidy_nmf <- nmf(tax_STB_year_tidy, rank = k)
W <- tax_STB_year_tidy_nmf@fit@W
H <- tax_STB_year_tidy_nmf@fit@H

province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
    province_cluster[i] <- which(H[,i]==max(H[,i]))
}
cluster_tax_STB_year <- data.frame(Province=colnames(tax_STB_year_tidy),province_cluster)
cluster_tax_STB_year$province_cluster <- as.factor(cluster_tax_STB_year$province_cluster)

map_cluster <- cnmap                                                  %>% 
    plyr::join(cluster_tax_STB_year, by = "Province")  

pdf('Stat550/Figure/map_cluster_tax_STB_year.pdf',width = 8,height = 6)
map_cluster                                                             %>%
    ggplot(aes(x = long, y = lat, group = group, fill = province_cluster))   +
    geom_polygon(color = "grey") +
    scale_fill_brewer(name="Province Cluster",
                      palette="Spectral",
                      labels=c("Cluster 1", "Cluster 2", "Cluster 3", "No Staffing Number")) +
    labs(x = "Longitude",
         y = "Latitude") +
    ggtitle('Clustering Map for Chinese Government Agency STB')

dev.off()
