
#setwd("C:/Users/Katie/Desktop/STAT-450")
#source("funFEM.R")
#setwd("C:/Users/Katie/Downloads")

setwd("C:/Users/Castaire/Desktop/analysis_attempt")
library("fda")
library("funFEM")
library("Funclustering")

epa_color <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b")

EPA_Cluster <- function(dept=NA, level=NA, k){
  #setwd("C:/Users/Katie/Desktop/data/Environmental protection data")
  setwd("C:/Users/Castaire/Desktop/analysis_attempt/EPA_Data")
  
  # variables
  departments = c('Education','EPA','Inspection', 'Information', 'Monitoring', 'Other', 'Research')
  levels = c('County', 'Provincial', 'Prefectural', 'Township')
  
  # error checking
  if (!is.na(dept) && !is.na(level)) stop("Both dept and level chosen \n", call.=FALSE)
  if (!is.na(dept)){
    if (any(!dept%in%departments)) stop("Invalid department name\n",call.=FALSE)
    filename = paste(dept, 'Dept.csv', sep="")
    dat = read.csv(filename, header=T)
  }
  if (!is.na(level)){
    if (any(!level%in%levels)) stop("Invalid level name \n", call.=FALSE)
    filename = paste(level, 'Level.csv', sep="")
    dat = read.csv(filename, header=T)
  }
  
  # prep
  dat = dat[ , colSums(is.na(dat)) == 0]
  years = dat[,1]
  dat = dat[-c(1)]
  row.names(dat) = years
  y = as.matrix(dat)
  
  
  # spline + clustering
  #basis = create.bspline.basis(rangeval = 1:length(years), nbasis=NULL, norder=4, breaks=NULL)
  basis = create.bspline.basis(rangeval = years, nbasis=NULL, norder=4, breaks=NULL)
  fdobj = Data2fd(years, y, basisobj = basis)
  fdobj$coefs[fdobj$coefs<0] = 0
  res = funFEM(fdobj,K=k,model="all",init = "kmeans",lambda=0,disp=TRUE)
  ret = list()
  for (i in 1:k){
    ret[[i]] =names(dat)[res$cls==i]
  }
  
  # adjust plot colors (ONLY FOR K = 6)
  final_col <- res$cls
  if(k == 6){
    for(i in 1:length(res$cls)){
      final_col[i] <- epa_color[res$cls[i]]
    }
  }
  
  # plot
  if(!is.na(level)){
    plotfd(fdobj, final_col, xlab="Year", ylab="Proportion of Staff",
           main=paste("Functional Data Curves : Level :", level))
    print(level)
  }else if(!is.na(dept)){
    plotfd(fdobj, final_col, xlab="Year", ylab="Proportion of Staff",
           main=paste("Functional Data Curves : Department :", dept))
    print(dept)
  }
  ret
}

# test
EPA_Cluster(dept = "Monitoring", k = 6)

##similarity matrix
dat = read.csv("ProvincialLevel.csv", header=T)
provinces = names(dat)[-c(1)]
simmatrixDept = matrix(0,nrow = 30, ncol = 30)
row.names(simmatrixDept) = provinces
colnames(simmatrixDept) = provinces
simmatrixLevel = matrix(0, nrow = 30, ncol = 30)
row.names(simmatrixLevel) = provinces
colnames(simmatrixLevel) = provinces

departments = c('Education','EPA','Inspection', 'Information', 'Monitoring', 'Other', 'Research')
for (i in 1:length(departments)){
  c = EPA_Cluster(dept = departments[i], k=6)
  print(c)
  for (j in 1:length(c)){
    simmatrixDept[c[[j]], c[[j]]] = simmatrixDept[c[[j]], c[[j]]] + 1
  }
}

levels = c('County', 'Provincial', 'Prefectural', 'Township')
for (i in 1:length(levels)){
  c = EPA_Cluster(level = levels[i], k=6)
  print(c)
  for (j in 1:length(c)){
    simmatrixLevel[c[[j]], c[[j]]] = simmatrixLevel[c[[j]], c[[j]]] + 1
  }
}

simmatrixDept = as.data.frame(simmatrixDept)
simmatrixLevel = as.data.frame(simmatrixLevel)
#m = as.data.frame(m)
setwd("C:/Users/Castaire/Desktop/analysis_attempt")
library(xlsx)
write.xlsx(simmatrixDept, "similarityDept.xlsx")
write.xlsx(simmatrixLevel, "similarityLevel.xlsx")

#dat = dat[which(dat$Department==dept), ]
#dat = aggregate(dat$Number.of.Staff, by=list(Category=dat$Province, dat$ï..Year, dat$Department), FUN=sum)
#datfd = spread(dat, key = Category, value  = x)
#fdmeans = fdobj
#fdmeans$coefs = t(res$prms$my)
#plot(fdmeans,col=1:res$K,xaxt='n')



