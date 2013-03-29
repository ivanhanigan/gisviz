
################################################################
# name:plotMyMap
plotMyMap <- function(location, xl = c(-180,180), yl = c(-50,50), googlemaps = F){
  if (!require(maps)) install.packages('maps'); require(maps)
  if (!require(ggmap)) install.packages('ggmap'); require(ggmap)
  if (!require(maptools)) install.packages('maptools'); require(maptools)
  map('world', xlim = xl, ylim = yl)
  box()
  if(diff(xl) > 300) {
    axis(1);axis(2)
  } else {
    map.scale(ratio=F)
  }
  if(googlemaps == T){
    points(geocode(location), pch =16, col = 'red')
  } else {
    points(location[1,], pch =16, col = 'red')
  }
  
}
