# Load library
library(tidyverse)

# Read data
tax_data_LTB <- read.csv("AgeLTBForR.csv")
tax_data_STB <- read.csv("AgeSTBForR.csv")

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

#-------------------------
tax_data_LTB <- read.csv("AgeLTBForR.csv")
exp_var <- read.csv("econdemographic.csv")
colnames(tax_data_LTB)[3] <- 'Number.of.Staff'
tax_LTB_all <- tax_data_LTB[, c(1:3)]
#tax_LTB_all <- rbind(tax_LTB_all[1:18, ], c("1996", "Chongqing", NA), tax_LTB_all[19:nrow(tax_LTB_all), ])
tax_LTB_ratio <- left_join(tax_LTB_all, exp_var, by=c("Year", "Province"))
tax_LTB_ratio <- tax_LTB_ratio[, c(1,2,3,10)]

tax_LTB_ratio$Number.of.Staff <- as.numeric(as.character(tax_LTB_ratio$Number.of.Staff))
tax_LTB_ratio$Number.of.Staff[83] <- 21520
tax_LTB_ratio$staff_ratio <- tax_LTB_ratio$Number.of.Staff/tax_LTB_ratio$Population
tax_LTB_ratio <- tax_LTB_ratio[complete.cases(tax_LTB_ratio), ]

allYears <- unique(tax_LTB_ratio$Year)
allProv <- unique(tax_LTB_ratio$Province)

tax_LTB_ratio_tidy <- matrix(tax_LTB_ratio$staff_ratio, nrow=length(allYears), ncol=length(allProv))
colnames(tax_LTB_ratio_tidy) <- allProv
rownames(tax_LTB_ratio_tidy) <- allYears

write.csv(tax_LTB_ratio_tidy, file="tax_LTB_ratio_tidy.csv")



tax_data_STB <- read.csv("AgeSTBForR.csv")
exp_var <- read.csv("econdemographic.csv")
colnames(tax_data_STB)[3] <- 'Number.of.Staff'
tax_STB_all <- tax_data_STB[, c(1:3)]
#tax_LTB_all <- rbind(tax_LTB_all[1:18, ], c("1996", "Chongqing", NA), tax_LTB_all[19:nrow(tax_LTB_all), ])
tax_STB_ratio <- left_join(tax_STB_all, exp_var, by=c("Year", "Province"))
tax_STB_ratio <- tax_STB_ratio[, c(1,2,3,10)]

tax_STB_ratio$Number.of.Staff <- as.numeric(as.character(tax_STB_ratio$Number.of.Staff))
tax_STB_ratio$Number.of.Staff[83] <- 21520
tax_STB_ratio$staff_ratio <- tax_STB_ratio$Number.of.Staff/tax_STB_ratio$Population
tax_STB_ratio <- tax_STB_ratio[complete.cases(tax_STB_ratio), ]

allYears <- unique(tax_STB_ratio$Year)
allProv <- unique(tax_STB_ratio$Province)

tax_STB_ratio_tidy <- matrix(tax_STB_ratio$staff_ratio, nrow=length(allYears), ncol=length(allProv))
colnames(tax_STB_ratio_tidy) <- allProv
rownames(tax_STB_ratio_tidy) <- allYears

write.csv(tax_STB_ratio_tidy, file="tax_STB_ratio_tidy.csv")
