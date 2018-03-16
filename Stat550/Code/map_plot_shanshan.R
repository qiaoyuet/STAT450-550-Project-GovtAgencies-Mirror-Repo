# Preparation
# Load packages 
library(maptools)
library(dplyr)
library(ggplot2)
library(ggvis)

# Map data has Chinese column 
# But seems like it still cannot display Chinese
# Maybe can delete the Chinese column
Sys.setlocale(category = "LC_ALL",locale = "Chinese")

# Raw Data
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
# head(cnmapdf)

# Coordinates of Province Capitals
# Set the capital coordinates of each provinces.
# We can also delete the Chinese column.

cap_coord <- c(
  "Beijing", "北京", "Beijing", 116.4666667, 39.9,
  "Shanghai", "上海", "Shanghai", 121.4833333, 31.23333333,
  "Tianjin", "天津", "Tianjin", 117.1833333, 39.15,
  "Chongqing", "重庆", "Chongqing", 106.5333333, 29.53333333,
  "Harbin", "哈尔滨", "Heilongjiang", 126.6833333, 45.75,
  "Changchun", "长春", "Jilin", 125.3166667, 43.86666667,
  "Shenyang", "沈阳", "Liaoning", 123.4, 41.83333333,
  "Hohhot", "呼和浩特", "Inner Mongolia", 111.8, 40.81666667,
  "Shijiazhuang", "石家庄", "Hebei", 114.4666667, 38.03333333,
  "Taiyuan", "太原", "Shanxi", 112.5666667, 37.86666667,
  "Jinan", "济南","Shandong", 117, 36.63333333,
  "Zhengzhou", "郑州", "Henan", 113.7, 34.8, 
  "Xi'an", "西安", "Shaanxi", 108.9, 34.26666667,
  "Lanzhou", "兰州", "Gansu", 103.8166667, 36.05,
  "Yinchuan", "银川", "Ningxia", 106.2666667, 38.33333333,
  "Xining", "西宁", "Qinghai", 101.75, 36.63333333,
  "Urumqi", "乌鲁木齐", "Xinjiang", 87.6, 43.8,
  "Hefei", "合肥", "Anhui", 117.3, 31.85,
  "Nanjing", "南京", "Jiangsu", 118.8333333, 32.03333333,
  "Hangzhou", "杭州", "Zhejiang", 120.15, 30.23333333,
  "Changsha", "长沙", "Hunan", 113, 28.18333333,
  "Nanchang", "南昌", "Jiangxi", 115.8666667, 28.68333333,
  "Wuhan", "武汉", "Hubei", 114.35, 30.61666667,
  "Chengdu", "成都", "Sichuan", 104.0833333, 30.65,
  "Guiyang", "贵阳", "Guizhou", 106.7, 26.58333333,
  "Fuzhou", "福州", "Fujian", 119.3, 26.08333333,
  "Taibei", "台北", "Taiwan", 121.5166667, 25.05,
  "Guangzhou", "广州", "Guangdong", 113.25, 23.13333333,
  "Haikou", "海口", "Hainan", 110.3333333, 20.03333333,
  "Nanning", "南宁", "Guangxi", 108.3333333, 22.8,
  "Kunming", "昆明", "Yunnan", 102.6833333, 25,
  "Lhasa", "拉萨", "Tibet", 91.16666667, 29.66666667,
  "Hong Kong", "香港", "Hong Kong", 114.1666667, 22.3,
  "Macau", "澳门", "Macau", 113.5, 22.2)
cap_coord <- as.data.frame(matrix(cap_coord, nrow = 34, byrow = TRUE))
names(cap_coord) <- c("city_en", "city_cn", "prov_en", "long", "lat")
cap_coord <- cap_coord                                              %>%
  mutate(prov_en = as.vector(prov_en),
         city_en = as.vector(city_en),
         city_cn = as.vector(city_cn),
         cap_long = as.double(as.vector(long)),
         cap_lat = as.double(as.vector(lat)))                       %>%
  select(prov_en, city_en, city_cn, cap_long, cap_lat)

# Combining the Tax Data
# Add Tax Data
staff <- read.csv('AgeLTBforR.csv')
colnames(staff)[2]='prov_en'
colnames(staff)[3]='staff_num'

# I just use the data in 1996 to test it.
# We can dig into it later.
# And I think we can also merge the cluster data to plot.

map2df <- cnmapdf                                                   %>% 
  plyr::join(subset(staff, Year == "1996")[1:3], by = "prov_en")  %>%
  mutate(staff_num = as.numeric(as.character(staff_num)))

pdf('Stat550/Figure/map.pdf',width = 8,height = 6)
map2df                                                              %>%
  ggplot(aes(x = long, y = lat, group = group, fill = staff_num))   +
  geom_polygon(color = "grey")
dev.off()
