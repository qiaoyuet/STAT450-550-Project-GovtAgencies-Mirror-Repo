library("dplyr")
d <- read.csv("C:/Users/Castaire/Desktop/data/Final Data/tax_tableau_data/AgeForTableau.csv")
d[is.na(d)] <- 0
temp <- aggregate(as.numeric(d$Number.of.Staff), by=list(d$Year, d$Province), FUN=sum)
temp2 <- rbind(temp[1:18,], c("1996", "Chongqing", 0), temp[19:287,])

allYears <- unique(temp2$Group.1)
allProv <- unique(temp2$Group.2)

temp2.1 <- temp2[,3]
final <- matrix(temp2.1, nrow=length(allYears), ncol=length(allProv))
colnames(final) <- allProv
rownames(final) <- allYears

#write.csv(final, file="TotalStaff.csv")
