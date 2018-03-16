library(maptools)

x=readShapeSpatial("stat550/CHN_adm1.shp")
plot(x)

ColorFcn=function(mapdata,province,provcol,othercol) { 
  f=function(x,y) {ifelse(x %in% y,which(y==x),0)}
  colIndex=sapply(x@data$NAME_1,f,province)
  col=c(othercol,provcol)[colIndex+1]
  return(col)}

provname=c("Guangdong","Beijing","Shandong","Fujian") 
provcol = c("pink", "red", "light blue", "purple")
plot(x, col= ColorFcn(x, provname, provcol, "white"))

