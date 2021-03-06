
################################################################
# name:plotMyMap
plotMyMap <- function(location, xl = c(-180,180), yl = c(-50,50), googlemaps = F){
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
    points(location, pch =16, col = 'red')
  }
  
}
