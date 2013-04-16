
################################################################
# name:gGeoCode2

getDocNodeVal <- function(doc, path){
  sapply(getNodeSet(doc, path), function(el) xmlValue(el))
}

gGeoCode2 <- function(str, first=T){
  textname <- str
  str <- gsub(' ','%20',str)
  u <- sprintf(
               'https://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address=%s',
               str
               )
  xml.response <- getURL(u, ssl.verifypeer=FALSE)
  doc <- xmlTreeParse(xml.response, useInternal=TRUE, asText=TRUE)
  lat <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lat')
  lng <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lng')

  if(length(lng) == 1 & first == F){
    out <- c(textname, lat, lng)
  } else if(length(lng) >= 1 & first == T) {
    out <- c(textname, lat[1], lng[1])
  } else {
    out <- c(textname, NA, NA)
  }
  out <- as.data.frame(t(out))
  names(out) <- c('address','lat','long')
  out$address <- as.character(out$address)
  out$lat <- as.numeric(as.character(out$lat))
  out$long <- as.numeric(as.character(out$long))
  return(out)

}
