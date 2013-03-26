
\name{plotMap}
\alias{plotMap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plot a Choropleth Map
}
\description{
Plot a Choropleth Map
}
\usage{
plotMap(stat = NA, plotdir = getwd(), probs = seq(0, 1, 0.2), outfile = NA, maptitle = "map", cellsmap = NA, region.map = NA)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{maptitle}{

}
  \item{stat}{
the column with the statistic to be plotted
}
  \item{region.map}{
if using a polygon
}
  \item{cellsmap}{
if using a raster, can be same as region.map
}
  \item{plotdir}{
write out a graph
}
  \item{probs}{
quantiles at which to break, default is quintiles, limit is 9
}
  \item{outfile}{
output map file
}



}
\value{
a map
}
\references{
http://stackoverflow.com/questions/1260965/developing-geographic-thematic-maps-with-r

Eduardo Leoni
http://stackoverflow.com/a/1261288
}
\author{
ivanhanigan
}
\examples{
Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
Sr3 = Polygon(cbind(c(4,4,5,10,4),c(5,3,2,5,5)))
Sr4 = Polygon(cbind(c(5,6,6,5,5),c(4,4,3,3,4)), hole = TRUE)
Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr3, Sr4), "s3/4")
SpP = SpatialPolygons(list(Srs1,Srs2,Srs3), 1:3)
plot(SpP, col = 1:3, pbg="white")
attr = data.frame(a=1:3, b=3:1, row.names=c("s3/4", "s2", "s1"))
SrDf = SpatialPolygonsDataFrame(SpP, attr)
plot(SrDf)
plotMap("title", stat = "b",region.map= SrDf)
}