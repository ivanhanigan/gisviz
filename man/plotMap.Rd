
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
  \item{stat}{
the column with the statistic to be plotted
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
  \item{maptitle}{

}
  \item{cellsmap}{
if using a raster, can be same as region.map
}
  \item{region.map}{
if using a polygon
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
