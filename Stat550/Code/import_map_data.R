# Preparation
# Load packages 
library(maptools)
# Map data has Chinese column
# I try to modify local settings in case of Chinese characters not displaying.
# using Sys.setlocale(category = "LC_ALL",locale = "Chinese")
# But seems like it still cannot display Chinese
# Maybe can delete the Chinese column
# Sys.setlocale(category = "LC_ALL",locale = "Chinese")

# Load Raw Data
# Subset the polygons with AREA larger than 0.005 and remove the N/A.

cnmap <- readShapePoly("./Data/china_province_border_data/bou2_4p.shp")
cnmap@data <- na.omit(cnmap@data)
cnmap@data$ID <- row.names(cnmap@data)
cnmap <- subset(cnmap, AREA > 0.005)
cnmap@data <- na.omit(cnmap@data)

# Create a data.frame called cnmapdf which contains id, prov_en and prov_cn 
# and key map plotting info:

prov_cn <- unique(cnmap$NAME)
prov_en <- c("Heilongjiang", "Inner Mongolia", "Xinjiang", "Jilin",
             "Liaoning", "Gansu", "Hebei", "Beijing", "Shanxi",
             "Tianjin", "Shaanxi", "Ningxia", "Qinghai", "Shandong",
             "Tibet", "Henan", "Jiangsu", "Anhui", "Sichuan", "Hubei",
             "Chongqing", "Shanghai", "Zhejiang", "Hunan", "Jiangxi",
             "Yunnan", "Guizhou", "Fujian", "Guangxi", "Taiwan", 
             "Guangdong", "Hong Kong", "Hainan")
prov <- data.frame(prov_cn, prov_en)
id_prov <- cnmap@data                                               %>%
  mutate(prov_en = sapply(NAME, 
                          function(x)
                            prov$prov_en[which(prov_cn == x)]))     %>%
  mutate(prov_cn = as.character(NAME),
         prov_en = as.character(prov_en))                           %>%
  select(id = ID, prov_cn, prov_en)
# use plyr package in a more efficient way
cnmapdf <- plyr::join(fortify(cnmap), id_prov, by = "id")
cnmapdf <- cnmapdf[,-8]
write.csv(cnmapdf, file="./Data/cnmapdf.csv")
# head(cnmapdf)
