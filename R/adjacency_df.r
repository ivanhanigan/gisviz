
################################################################
# name:adjacency_df
adjacency_df <- function(NB, shp, zone_id)
  {
    adjacencydf <- as.data.frame(matrix(NA, nrow = 0, ncol = 2))
    for(i in 1:length(NB))
    {
      if(length(shp[[zone_id]][NB[[i]]]) == 0) next
      adjacencydf <- rbind(adjacencydf, cbind(as.character(shp[[zone_id]][i]),as.character(shp[[zone_id]][NB[[i]]])))
    }
    return(adjacencydf)
  }
