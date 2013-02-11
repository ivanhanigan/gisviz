

gGeoCode2 <- function(str, first=T){
  if(!require(XML)) install.packages('XML'); require(XML)
  if(!require(RCurl)) install.packages('RCurl'); require(RCurl)
  getDocNodeVal=function(doc, path){
    sapply(getNodeSet(doc, path), function(el) xmlValue(el))
  }
  
  
  str=gsub(' ','%20',str)
  u=sprintf('https://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address=%s',str)
  xml.response <- getURL(u, ssl.verifypeer=FALSE)
  
  doc = xmlTreeParse(xml.response, useInternal=TRUE, asText=TRUE)
  
  
  
  lat=getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lat')
  lng=getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lng')
  if(length(lng) == 1 & first == F){
    
    out<-c(str, lat, lng)
  } else if(length(lng) >= 1 & first == T) {
    out<-c(str, lat[1], lng[1])
  } else {
    out<-c(str, NA, NA)
  }
  out<-as.data.frame(t(out))
  names(out) <- c('address','lat','long')
  return(out)
  
}


# address <- "1 Lineaus way acton canberra"
# gGeoCode2(address)
