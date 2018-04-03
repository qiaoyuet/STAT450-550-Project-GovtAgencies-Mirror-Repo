
library("fda")
library("funFEM")
library("Funclustering")

setwd("C:/Users/Castaire/Desktop/data")
d <- read.csv("TotalStaff.csv", header=TRUE)
d <- d[-1,]
d <- d[,-31] # remove 'Yangzhou'

# prep data
d <- d[,colSums(is.na(d)) == 0]
years <- d[,1]
d <- d[-c(1)]
row.names(d) <- years
y <- as.matrix(d)

# spline + clustering (k=6)
basis = create.bspline.basis(rangeval = years, nbasis=NULL, norder=4, breaks=NULL)
fdobj = Data2fd(years, y, basisobj = basis)
fdobj$coefs[fdobj$coefs<0] = 0
res = funFEM(fdobj,K=6,model="all",init = "kmeans",lambda=0,disp=TRUE)
ret = list()
for (i in 1:6){
  ret[[i]] = names(d)[res$cls==i]
}

# plot
ts_color <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b")
plotfd(fdobj, ts_color, xlab="Year", ylab="Total Staff",
       main="Functional Data Curves : Total Staff")





