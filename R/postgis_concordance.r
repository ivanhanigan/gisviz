
################################################################
# name:postgis_concordance
postgis_concordance <- function(conn, source_table, source_zones_code,
                                target_table, target_zones_code,
                                into = paste(source_table, "_concordance", sep = ""),
                                tolerance = 0.01,
                                subset_target_table = NA, 
                                eval = F
                                )
{
  
sql <- paste("
select source_zone_code, source_zones, 
  target_fid, target_zone_code, prop_olap_src_of_tgt,
  prop_olap_src_segment_of_src_orig, geom
frominto
(
select    src.zone_code as source_zone_code,
          tgt.gid as target_fid, tgt.zone_code as target_zone_code, source_zones,
          st_intersection(src.geom, tgt.geom) as geom,
          st_area(src.geom) as src_area,
          st_area(tgt.geom) as tgt_area,
          st_area(st_intersection(src.geom, tgt.geom )) as area_overlap,
          st_area(st_intersection(src.geom, tgt.geom
                                  ))/st_area(tgt.geom) as
          prop_olap_src_of_tgt,
          st_area(st_intersection(src.geom, tgt.geom
                                  ))/st_area(src.geom) as
          prop_olap_src_segment_of_src_orig
from
(
select ",source_zones_code," as zone_code, cast('",source_table,"' as text) as source_zones, *
from ",source_table,"
) src,
(
select gid, ",target_zones_code," as zone_code, geom
from ",target_table,"
) tgt
where st_intersects(src.geom, tgt.geom)
) concorded
where prop_olap_src_of_tgt > ",tolerance,";
grant select on ",into," to public_group;
", sep = "")
  
# if table exists add inserts, else
if(length(grep("\\.",into)) == 0)
{
  schema <- "public"
  table <- into
} else {
  schema <- strsplit(into, "\\.")[[1]][1]
  table <- strsplit(into, "\\.")[[1]][2]
}

tableExists <- pgListTables(conn, schema, table)
  
if(nrow(tableExists) != 0)
  {
    stop("table exists")
  } else {
    sql <-  gsub("frominto", paste("into ", into, "\nfrom", sep = ""), sql)
  }

  sql2 <- paste("\n
    alter table ",into," add column gid serial primary key;
    ", sep = "")
  sql3 <- paste("\n
    ALTER TABLE ",into," ALTER COLUMN geom SET NOT NULL;
    ", sep = "")
  sql4 <- paste("\n
    CREATE INDEX ",strsplit(into, "\\.")[[1]][2],"_gist on ",into," using GIST(geom);
    ", sep = "")
  sql5 <- paste("\n
    ALTER TABLE ",into," CLUSTER ON ",strsplit(into, "\\.")[[1]][2],"_gist;
    ", sep = "")
    
if(!is.na(subset_target_table))
  {
    sql <- gsub(") tgt", paste("where ", subset_target_table, "\n) tgt", sep = ""), sql)
  }
if(eval)
  {
    dbSendQuery(conn, sql)
    dbSendQuery(conn, sql2)
    dbSendQuery(conn, sql3)
    dbSendQuery(conn, sql4)
    dbSendQuery(conn, sql5)    
  } else {
    return(c(sql, sql2, sql3, sql4, sql5))
  }
  
}
