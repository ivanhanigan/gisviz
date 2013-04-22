
################################################################
# name:postgis_concordance_multi
## postgis_concordance_multi <- function(conn, source_zone_layers, source_zones_code,
##                                 target_table, target_zones_code,
##                                 into = paste(source_table, "_concordance_multi", sep = ""),
##                                 tolerance = 0.01,
##                                 subset_target_table = NA,
##                                 eval = F
##                                 )
## {


##   for(i in 1:length(source_zone_layers))
##     {
       i  <- 1
      src_zone  <-  source_zone_layers[i]
#       src_zone

      #sql <-
      postgis_concordance(
                           conn = conn
                           ,
                           source_table = src_zone
                           ,
                           source_zones_code = source_zones_code
                           ,
                           source_attributes = NA
                           ,
                           target_table = target_table
                           ,
                           target_zones_code = target_zones_code
                           ,
                           into = paste(into, i, sep = "")
                           ,
                           tolerance = tolerance
                           ,
                           subset_target_table = subset_target_table
                           ,
                           eval = T
                           )
      #cat(sql)
      #dbSendQuery(conn, sql)
      ## src_zone_name  <- gsub("\\.", "_", src_zone)
       
      ## sql  <- paste("
      ## select gid, target_fid, target_zone_code,
      ##   source_zone_code as ",src_zone_name, ", geom
      ## into ",paste(into,"_out", i, sep = ""), "
      ## from ",into,"
      ## ", sep = "")
      ## cat(sql)                  
      ## dbSendQuery(conn, sql)
      ## dbSendQuery(conn, sprintf("drop table %s", into))
       i  <- 2
      src_zone  <-  source_zone_layers[i]
      src_zone
      #      sql <-
      postgis_concordance(
                           conn = conn
                           ,
                           source_table = src_zone
                           ,
                           source_zones_code = source_zones_code
                           ,
                           source_attributes = "source_zone_code as sla00"
                           ,
                           target_table = paste(into, i-1, sep = "")
                           ,
                           target_zones_code = "target_zone_code"
                           ,
                           into = paste(into, i, sep = "")
                           ,
                           tolerance = tolerance
                           ,
                           subset_target_table = NA
                           ,
                           eval = T
                           )
      #cat(sql)
      i  <- 3
      src_zone  <-  source_zone_layers[i]
       src_zone
            sql <-
      postgis_concordance(
                           conn = conn
                           ,
                           source_table = src_zone
                           ,
                           source_zones_code = source_zones_code
                           ,
                           source_attributes = "sla00, source_zone_code as sla01"
                           ,
                           target_table = paste(into, i-1, sep = "")
                           ,
                           target_zones_code = "target_zone_code"
                           ,
                           into = paste(into, i, sep = "")
                           ,
                           tolerance = tolerance
                           ,
                           subset_target_table = NA
                           ,
                           eval = F
                           )
      cat(sql)
#
#    }
#}
