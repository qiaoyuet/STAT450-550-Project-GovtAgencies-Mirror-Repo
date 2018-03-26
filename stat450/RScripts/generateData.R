# setup
setwd("C:/Users/Castaire/Desktop/data/Final Data/tax_tableau_data")
library("dplyr")

# data
d.age <- read.csv("AgeforTableau.csv", header=TRUE)
d.age <- subset(d.age, d.age$Province != "Yangzhou")
d.edu <- read.csv("EduforTableau.csv", header=TRUE)
d.edu <- subset(d.edu, d.edu$Province != "Yangzhou")
d.unit <- read.csv("UnitforTableau.csv", header=TRUE)
d.unit <- subset(d.unit, d.unit$Province != "Yangzhou")

# N/A -> 0
d.age[is.na(d.age)] <- 0
d.edu[is.na(d.edu)] <- 0
d.unit[is.na(d.unit)] <- 0

# AGE
age.sum <- aggregate(as.numeric(d.age$Number.of.Staff), by=list(d.age$Year, d.age$Province, d.age$Age), FUN=sum)
colnames(age.sum) <- c("Year", "Province", "Age.Level", "Num.of.Staff")
age.sum <- subset(age.sum, age.sum$Year!=1996)

age.total2 <- aggregate(as.numeric(d.age$Number.of.Staff), by=list(d.age$Year, d.age$Province), FUN=sum)
age.total2 <- subset(age.total2, age.total2$Group.1 != 1996)

process.age <- function(age.lvl){
  temp <- aggregate(as.numeric(age.sum$Num.of.Staff), by=list(age.sum$Year, age.sum$Province, age.sum$Age==age.lvl), FUN=sum)
  temp <- subset(temp, temp$Group.3==TRUE)
  temp <- temp[,-3]
  colnames(temp) <- c("Year", "Province", "Num.of.Staff")
  
  allYears <- unique(temp$Year)
  allProv <- unique(temp$Province)
  
  temp2 <- temp[,3] / age.total2[,3]
  final <- matrix(temp2, nrow=length(allYears), ncol=length(allProv))
  colnames(final) <- allProv
  final <- cbind(allYears, final)
  colnames(final)[1] <- "Year"
  
  return(final)
}

# age levels:  <30, 31-35, 35-40, 41-45, 46-50, 51-54, 55-59, >60 (keep for now)
less.than.30 <- process.age("<30")
age.31.35 <- process.age("31-35")
age.35.40 <- process.age("35-40")
age.41.45 <- process.age("41-45")
age.46.50 <- process.age("46-50")
age.51.54 <- process.age("51-54")
age.55.59 <- process.age("55-59")
over.60 <- process.age(">60") # this one is funky >.<

setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt/TAX_Data")
write.csv(less.than.30, file="less.than.30.csv", row.names=FALSE)
write.csv(age.31.35, file="age.31.35.csv", row.names=FALSE)
write.csv(age.35.40, file="age.35.40.csv", row.names=FALSE)
write.csv(age.41.45, file="age.41.45.csv", row.names=FALSE)
write.csv(age.46.50, file="age.46.50.csv", row.names=FALSE)
write.csv(age.51.54, file="age.51.54.csv", row.names=FALSE)
write.csv(age.55.59, file="age.55.59.csv", row.names=FALSE)
write.csv(over.60, file="over.60.csv", row.names=FALSE)



# EDU 
edu.sum <- aggregate(as.numeric(d.edu$Number.of.Staff), by=list(d.edu$Year, d.edu$Province, d.edu$Education), FUN=sum)
colnames(edu.sum) <- c("Year", "Province", "Education", "Num.of.Staff")
edu.sum <- subset(edu.sum, edu.sum$Year!=1996)

edu.total2 <- aggregate(as.numeric(d.edu$Number.of.Staff), by=list(d.edu$Year, d.edu$Province), FUN=sum)
edu.total2 <- subset(edu.total2, edu.total2$Group.1 != 1996)

process.edu <- function(edu.lvl){
  temp <- aggregate(as.numeric(edu.sum$Num.of.Staff), by=list(edu.sum$Year, edu.sum$Province, edu.sum$Education==edu.lvl), FUN=sum)
  temp <- subset(temp, temp$Group.3==TRUE)
  temp <- temp[,-3]
  colnames(temp) <- c("Year", "Province", "Num.of.Staff")
  
  allYears <- unique(temp$Year)
  allProv <- unique(temp$Province)
  
  temp2 <- temp[,3] / edu.total2[,3]
  final <- matrix(temp2, nrow=length(allYears), ncol=length(allProv))
  colnames(final) <- allProv
  final <- cbind(allYears, final)
  colnames(final)[1] <- "Year"
  
  return(final)
}

# edu levels: (see below)
bachelors <- process.edu("Bachelors")
highschool <- process.edu("HighSchool")
juniorhigh <- process.edu("JuniorHigh")
otherpostsec <- process.edu("OtherPostSecondary")
postgrad <- process.edu("PostGraduate")
techcollege <- process.edu("TechnicalCollege")

setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt/TAX_Data")
write.csv(bachelors, file="bachelor.csv", row.names=FALSE)
write.csv(highschool, file="highschool.csv", row.names=FALSE)
write.csv(juniorhigh, file="juniorhigh.csv", row.names=FALSE)
write.csv(otherpostsec, file="otherpostsecondary.csv", row.names=FALSE)
write.csv(postgrad, file="postgrad.csv", row.names=FALSE)
write.csv(techcollege, file="technicalcollege.csv", row.names=FALSE)
