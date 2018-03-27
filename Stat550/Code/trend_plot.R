library(ggplot2)

tax_data_LTB <- read.csv("AgeLTBForR.csv")
colnames(tax_data_LTB)[3] <- 'Number.of.Staff'
tax_LTB_all <- tax_data_LTB[, c(1:3)]
levels(tax_LTB_all$Province)[levels(tax_LTB_all$Province)=="Inner Mongolia"] <- "Inner.Mongolia"

tax_LTB_all_tidy <- read.csv("tax_LTB_all_tidy.csv")
tax_LTB_all_tidy <- tax_LTB_all_tidy[-1,-1]
tax_LTB_all_tidy$Hebei <- as.numeric(as.character(tax_LTB_all_tidy$Hebei))
tax_LTB_all_tidy[2,10] <- 21520
tax_LTB_year_tidy_nmf <- nmf(tax_LTB_all_tidy, rank = 3)
W <- tax_LTB_year_tidy_nmf@fit@W
H <- tax_LTB_year_tidy_nmf@fit@H
province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
  province_cluster[i] <- which(H[,i]==max(H[,i]))
}
cluster_tax_LTB_all <- data.frame(Province=colnames(tax_LTB_year_tidy_nmf),province_cluster)
tmp <- left_join(tax_LTB_all,cluster_tax_LTB_all, by="Province")

# ggplot(tmp, aes(x=tmp$Year, y=tmp$Number.of.Staff)) +
#   geom_path() +
#   facet_wrap(~tmp$province_cluster)

tmp %>% 
  filter(province_cluster == 1) %>% 
  arrange(Year) %>% 
  ggplot(aes(x=Year, y=Number.of.Staff, group=Province)) + geom_path(aes(color=Province))
