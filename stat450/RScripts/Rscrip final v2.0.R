dat <- read.csv("TotalStaff.csv")
library(Funclustering)
datmatrix <- as.matrix(dat[,-1])
# norder = 3 or 4?
splines <- create.bspline.basis(rangeval=c(1996, 2007), nbasis = 25, norder=3)
fd1 <- Data2fd(datmatrix, argvals= c(1999:2007), basisobj = splines);
#plot the original curves
plotOC(dat$X,  dat)
#plot the smoothed curves
plotfd(fd1)

# K needs to be smaller than #of basis
res2=funclust(fd1, K=2)
res2$cls 
plotfd(fd1,col=res2$cls)

##cons: unstable: each time we run clustering a distinctive one is different
#PCA
pca=mfpca(fd1,nharm=2)
mfpcaPlot(pca, c(2,1))


library("NMF")
