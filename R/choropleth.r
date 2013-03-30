
################################################################
# name:choropleth
################################################################
# A general mapping function, form of which was taken from here:
# http://stackoverflow.com/questions/1260965/developing-geographic-thematic-maps-with-r
################################################################

choropleth <- function(maptitle = 'map', stat=NA, region.map=NA,
                    brew.pal = "RdYlBu",
                    invert.brew.pal = TRUE,
                    cellsmap=region.map, scalebar = TRUE,
                    xl = NA, yl = NA,
                    probs=seq(0,1,.2)
                    )
{
  level.labels <- get.levels(cellsmap=cellsmap,stat=stat,probs=probs)
  # create a new variable in cells.map to bin the data into categories
  cells.map <- cellsmap
  bins <- quantile(cells.map@data[,stat], probs, na.rm=T)
  cells.map@data$bins <- cut(cells.map@data[,stat],
                             bins, include.lowest=TRUE
                             )
  # Replace the character "levels" attribute with character colors
  col.vec <- brewer.pal(length(level.labels),brew.pal)
  if(invert.brew.pal == TRUE) col.vec <- col.vec[length(col.vec):1]
  levels(cells.map@data$bins) <- col.vec
  # Open a windows graphics device so that we can see what's happening
  # windows(11.7,8.3)
  # Split the figure to leave room at the right for a legend, and room
  # at the top margin for a title
  par(fig = c(0,0.7,0,1), mar=c(2,2,2,0))
  # plot the map object with no border around the rectangels, and with colors
  # dictated by new variable we created, which holds the colours as its levels
  # paramater.

  if(!is.na(xl)  & !is.na(yl))
    {
      plot(cells.map,
           border = FALSE,
           axes = FALSE,
           las = 1,
           col = as.character(cells.map@data$bins),
           xlim = xl, ylim = yl
           )
    } else {
      plot(cells.map,
           border = FALSE,
           axes = FALSE,
           las = 1,
           col = as.character(cells.map@data$bins)
           )
    }
  if(scalebar == FALSE)
    {
      axis(1);axis(2)
    } else {
      map.scale(ratio=F)
    }

  box()
  plot(region.map, add=TRUE, lwd=1)
  mtext(maptitle, side = 3, cex = 2, line = 0)
  par(fig = c(0.7,1,0,1), mar=c(0,0,0,0), new = FALSE)
  legend("left", level.labels, fill=col.vec, bty="n", xpd=TRUE,
        title="Legend")

}
