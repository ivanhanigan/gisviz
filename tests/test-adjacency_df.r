
################################################################
# name:adjacency_df
require(devtools)
load_all()
require(spdep)
fn <- system.file("etc/shapes/eire.shp", package="spdep")[1]
prj <- CRS("+proj=utm +zone=30 +units=km")
eire <- readShapeSpatial(fn, ID="names", proj4string=prj)
class(eire)
eire@data

plot(eire)
nb <- poly2nb(eire)
head(nb)
eire[['names']][1]
eire[['names']][nb[[1]]]
plot(nb, coordinates(eire), add=TRUE, pch=".", lwd=2)
adj <- adjacency_df(NB = nb, shp = eire, zone_id = 'names')
adj
