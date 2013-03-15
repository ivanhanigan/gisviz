
################################################################
# name:gGeoCode2


gGeoCode2 <- function(str, first=T){
  if(!require(XML)) install.packages('XML'); require(XML)
  if(!require(RCurl)) install.packages('RCurl'); require(RCurl)
  
  getDocNodeVal <- function(doc, path){
    sapply(getNodeSet(doc, path), function(el) xmlValue(el))
  }
  
  if(!is.data.frame(str) & length(str) == 1)
  {
    str <- gsub(' ','%20',str)
    u <- sprintf('https://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address=%s',str)
    xml.response <- getURL(u, ssl.verifypeer=FALSE)
    
    doc <- xmlTreeParse(xml.response, useInternal=TRUE, asText=TRUE)
    
    
    
    lat <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lat')
    lng <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lng')
    if(length(lng) == 1 & first == F){
      
      out <- c(str, lng, lat)
    } else if(length(lng) >= 1 & first == T) {
      out<-c(str, lng[1], lat[1])
    } else {
      out<-c(str, NA, NA)
    }
    out<-as.data.frame(t(out))
  } else {
    
    if(is.data.frame(str) & ncol(str) == 1){
      str <- as.character(str[,1])
    } else {
      stop("only character vectors or singlecolumn dataframes allowed")
    }
    
    pointTable<-as.data.frame(matrix(nrow=0, ncol=3))
    for(index in 1: length(str))
    {
      #index <- 1
      str2 <- gsub(' ','%20',str[index])
      u <- sprintf('https://maps.googleapis.com/maps/api/geocode/xml?sensor=false&address=%s',str2)
      xml.response <- getURL(u, ssl.verifypeer=FALSE)
      
      doc <- xmlTreeParse(xml.response, useInternal=TRUE, asText=TRUE)
      
      
      
      lat <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lat')
      lng <- getDocNodeVal(doc, '/GeocodeResponse/result/geometry/location/lng')
      
      if(length(lng) == 1 & first == F){
        
        out <- c(str2, lng, lat)
      } else if(length(lng) >= 1 & first == T) {
        out<-c(str2, lng[1], lat[1])
      } else {
        out<-c(str2, NA, NA)
      }
      pointTable<-rbind(pointTable,as.data.frame(t(out)))
    }
    #names(pointTable)<-c('Location', 'Latitude', 'Longitude')
    out <- pointTable
  }

  names(out) <- c('address','long','lat')
  out$long <- as.numeric(as.character(out$long))
  out$lat <- as.numeric(as.character(out$lat))
  
  return(out)
  
}



# address <- "1 Lineaus way acton canberra"
#address2 <- c("1 Lineaus way acton canberra", "15 follett street scullin")
#xy <- gGeoCode2(address2)
# xy
#str(xy)
