library(dplyr)
library(reshape2)
library(NMF)
library(mice)
library(abind)

d <- read.csv("AgeForTableau.csv")
# d[is.na(d)] <- 0
# temp <- aggregate(as.numeric(d$Number.of.Staff), by=list(d$Year, d$Province), FUN=sum)
# temp2 <- rbind(temp[1:18,], c("1996", "Chongqing", 0), temp[19:287,])

any(is.na(d$Number.of.Staff))
which(is.na(d$Number.of.Staff))
exp_var <- read.csv("econdemographic.csv")
temp <- aggregate(as.numeric(d$Number.of.Staff), by=list(d$Year, d$Province), FUN=sum)
temp2 <- rbind(temp[1:18,], c("1996", "Chongqing", NA), temp[19:287,])
colnames(temp2) <- c("Year", "Province","Number.of.Staff")
exp_var$Year <- as.character(exp_var$Year)
tmp <- left_join(temp2, exp_var, by=c("Year", "Province"))
str(tmp)
tmp$Number.of.Staff <- as.numeric(tmp$Number.of.Staff)
mice <- mice(tmp, m=5, visitSequence = c(4,5,6,7,8,9,10,11,12,13,3))
d1 <- complete(mice, action = 1)
d2 <- complete(mice, action = 2)
d3 <- complete(mice, action = 3)
d4 <- complete(mice, action = 4)
d5 <- complete(mice, action = 5)

NoStaff_imputed <- rowMeans(cbind(d1$Number.of.Staff, d2$Number.of.Staff, 
                                  d3$Number.of.Staff, d4$Number.of.Staff, d5$Number.of.Staff))
length(NoStaff_imputed)
temp2$Number.of.Staff <- NoStaff_imputed
View(temp2)

#allYears <- unique(temp2$Group.1)
#allProv <- unique(temp2$Group.2)

allYears <- unique(temp2$Year)
allProv <- unique(temp2$Province)

temp2.1 <- temp2[,3]
final <- matrix(temp2.1, nrow=length(allYears), ncol=length(allProv))
colnames(final) <- allProv
rownames(final) <- allYears

write.csv(final, file="TotalStaff_imputed.csv")

dat <- read.csv("TotalStaff_imputed.csv")
dat_mat <- data.matrix(dat)[,-1]

k=3
dat_nmf <- nmf(dat_mat, rank = k)
W <- dat_nmf@fit@W
H <- dat_nmf@fit@H
dim(W)
dim(H)

province_cluster <- rep(NA, ncol(H))
for (i in 1:ncol(H)) {
  province_cluster[i] <- which(H[,i]==max(H[,i]))
}
province_cluster

colnames(dat)[-1][which(province_cluster == 3)]
colnames(dat)[-1][which(province_cluster == 2)]
colnames(dat)[-1][which(province_cluster == 1)]
