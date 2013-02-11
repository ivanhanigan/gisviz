\name{gGeoCode2}
\alias{gGeoCode2}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
gGeoCode2
}
\description{
This is an HTTPS security enhanced version of the gGeoCode function from Ezgraphs. GoogleGeocodeMap.R, 2010. https://github.com/ezgraphs/R-Programs/blob/master/GoogleGeocodeMap.R. 
}
\usage{
gGeoCode2(str, first = T)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{str}{
address string
}
  \item{first}{
google may return multiple hits.  just return the first.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
address <- "1 Lineaus way acton canberra"
gGeoCode2(address)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ geocoding }
\keyword{ address }% __ONLY ONE__ keyword per line
