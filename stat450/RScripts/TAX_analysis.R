setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt")
library("fda")
library("funFEM")
library("Funclustering")

TAX_Cluster <- function(age.lvl=NA, edu.lvl=NA, k){
  setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt/TAX_Data")
  
  age = c("less.than.30", "over.60", "age.31.35", "age.35.40", "age.41.45", "age.46.50", "age.51.54", "age.55.59")
  edu = c("bachelor", "highschool", "juniorhigh", "otherpostsecondary", "postgrad", "technicalcollege")
  
  # error checking
  if (!is.na(age.lvl) && !is.na(edu.lvl)) stop("Both dept and level chosen \n", call.=FALSE)
  if (!is.na(age.lvl)){
    if (any(!age.lvl%in%age)) stop("Invalid age selection\n",call.=FALSE)
    filename = paste(age.lvl, '.csv', sep="")
    dat = read.csv(filename, header=T)
  }
  if (!is.na(edu.lvl)){
    if (any(!edu.lvl%in%edu)) stop("Invalid education selection \n", call.=FALSE)
    filename = paste(edu.lvl, '.csv', sep="")
    dat = read.csv(filename, header=T)
  }
  
  # prep
  dat = dat[ , colSums(is.na(dat)) == 0]
  years = dat[,1]
  dat = dat[-c(1)]
  row.names(dat) = years
  y = as.matrix(dat)
  
  # spine + clustering
  #basis = create.bspline.basis(rangeval = 1:length(years), nbasis=NULL, norder=4, breaks=NULL)
  basis = create.bspline.basis(rangeval = years, nbasis=NULL, norder=4, breaks=NULL)
  fdobj = Data2fd(years, y, basisobj = basis)
  fdobj$coefs[fdobj$coefs<0] = 0
  res = funFEM(fdobj,K=k,model="all",init = "kmeans",lambda=0,disp=TRUE)
  ret = list()
  for (i in 1:k){
    ret[[i]] = names(dat)[res$cls==i]
  }
  
  if(!is.na(age.lvl)){
    plotfd(fdobj, res$cls, xlab="Year", ylab="Proportion of Staff", 
           main=paste("Functional Data Curves : Age :", age.lvl))
  }else if(!is.na(edu.lvl)){
    plotfd(fdobj, res$cls, xlab="Year", ylab="Proportion of Staff", 
           main=paste("Functional Data Curves : Education :", edu.lvl))
  }
  print("Clusters: ")
  print(ret)
  ret
}

# testing
c.less.than.30 <- TAX_Cluster(age.lvl = "less.than.30", k=6)


### similarity matrix ###
setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt/TAX_Data")
dat <- read.csv("bachelor.csv")
provinces <- names(dat)[-c(1)]

simmatrixAge = matrix(0, nrow = length(provinces), ncol = length(provinces))
rownames(simmatrixAge) = provinces
colnames(simmatrixAge) = provinces

simmatrixEdu = matrix(0, nrow = length(provinces), ncol = length(provinces))
rownames(simmatrixEdu) = provinces
colnames(simmatrixEdu) = provinces

age = c("less.than.30", "over.60", "age.31.35", "age.35.40", "age.41.45", "age.46.50", "age.51.54", "age.55.59")
for (i in 1:length(age)){
  c = TAX_Cluster(age.lvl = age[i], k=6)
  for (j in 1:length(c)){
    simmatrixAge[ c[[j]], c[[j]] ] = simmatrixAge[ c[[j]], c[[j]] ] + 1
  }
}

edu = c("bachelor", "highschool", "juniorhigh", "otherpostsecondary", "postgrad", "technicalcollege")
for (i in 1:length(edu)){
  c = TAX_Cluster(edu.lvl = edu[i], k=6)
  for (j in 1:length(c)){
    simmatrixEdu[c[[j]], c[[j]]] = simmatrixEdu[c[[j]], c[[j]]] + 1
  }
}

simmatrixAge = as.data.frame(simmatrixAge)
#m = as.data.frame(m)
simmatrixEdu = as.data.frame(simmatrixEdu)

library(xlsx)
setwd("C:/Users/Castaire/Desktop/tax_analysis_attempt")
write.xlsx(simmatrixAge, "similarityAge_TAX.xlsx")
write.xlsx(simmatrixEdu, "similarityEdu_TAX.xlsx")



#dat = dat[which(dat$Department==dept), ]
#dat = aggregate(dat$Number.of.Staff, by=list(Category=dat$Province, dat$ï..Year, dat$Department), FUN=sum)
#datfd = spread(dat, key = Category, value  = x)
#fdmeans = fdobj
#fdmeans$coefs = t(res$prms$my)
#plot(fdmeans,col=1:res$K,xaxt='n')



