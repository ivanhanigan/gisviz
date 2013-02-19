
################################################################
# name:cells

################################################################################
# Function to return bin sizes for the map key            
################################################################################
get.levels = function(stat,cellsmap, probs=seq(0,1,.2)){
  cells.map=cellsmap
  bins = quantile(cells.map@data[,stat], probs, na.rm=T)  
  binlevels = cut(cells.map@data[,stat], bins, include.lowest=TRUE)
  groups = strsplit(levels(binlevels), ",")
# Get the beginning value for each group
  begins = sapply(groups, '[[', 1)
  begins = substr(begins, 2, nchar(begins))
# Get the beginning value for each group
  ends = sapply(groups, '[[', 2)
  ends = substr(ends, 1, nchar(ends)-1)
# Put begins and ends together into labels
  level.labels = paste(begins, ends, sep = " - ")
  qlevels = paste(as.character(probs[2:length(probs)]*100),"%:",sep="") 
  level.labels = paste(qlevels, level.labels)  
return(level.labels) 
}  
#get.levels(cellsmap=d,stat='DAILY_MAX_')
