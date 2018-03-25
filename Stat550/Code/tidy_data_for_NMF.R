# Load library
library(tidyverse)

# Read data
tax_data_LTB <- read.csv("D:/AgeLTBForR.csv")
tax_data_STB <- read.csv("D:/AgeSTBForR.csv")

#Tidy data
colnames(tax_data_LTB)[3] <- 'Number.of.Staff'
tax_LTB_all <- tax_data_LTB[, c(1:3)]
tax_LTB_all <- rbind(tax_LTB_all[1:18, ], c("1996", "Chongqing", NA), tax_LTB_all[19:nrow(tax_LTB_all), ])

allYears <- unique(tax_LTB_all$Year)
allProv <- unique(tax_LTB_all$Province)

temp <- tax_LTB_all[,3]
tax_LTB_all_tidy <- matrix(temp, nrow=length(allYears), ncol=length(allProv))
colnames(tax_LTB_all_tidy) <- allProv
rownames(tax_LTB_all_tidy) <- allYears

write.csv(tax_LTB_all_tidy, file="Stat550/ShinyApp/tax_LTB_all_tidy.csv")

#Tidy data for STB
colnames(tax_data_STB)[3] <- 'Number.of.Staff'
tax_STB_all <- tax_data_STB[, c(1:3)]
tax_STB_all <- rbind(tax_STB_all[1:26, ], c("1996", "Chongqing", NA), tax_STB_all[27:nrow(tax_STB_all), ])

allYears <- unique(tax_STB_all$Year)
allProv <- unique(tax_STB_all$Province)

temp <- tax_STB_all[,3]
tax_STB_all_tidy <- matrix(temp, nrow=length(allYears), ncol=length(allProv))
colnames(tax_STB_all_tidy) <- allProv
rownames(tax_STB_all_tidy) <- allYears

write.csv(tax_STB_all_tidy, file="Stat550/ShinyApp/tax_STB_all_tidy.csv")
