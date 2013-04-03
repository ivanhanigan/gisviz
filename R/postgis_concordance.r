
################################################################
# name:postgis_concordance
postgis_concordance <- function(conn, source_table, target_table,
                                into = paste(source_table, "_concordance", sep = ""),
                               tolerance = 0.01,
                               subset_target_table = NA,
                               eval = F)
{
sql <- paste("
select source_sla_code, source_zones, target_sla_code, prop_olap_src_of_tgt,
  prop_olap_src_segment_of_src_orig, geom
frominto
(
select    src.sla_code as source_sla_code,
          tgt.sla_code as target_sla_code, source_zones,
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
select sla_code, geom, cast('",source_table,"' as text) as source_zones
from ",source_table,"
) src,
(
select sla_code, geom
from ",target_table,"
) tgt
where st_intersects(src.geom, tgt.geom)
) concorded
where prop_olap_src_of_tgt > ",tolerance,";
grant select on ",into," to public_group;
", sep = "")

# if table exists add inserts, else
sql <-  gsub("frominto", paste("into ", into, "\nfrom", sep = ""), sql)
sql <- c(sql,paste("\n
alter table ",into," add column gid serial primary key;
ALTER TABLE ",into," ALTER COLUMN geom SET NOT NULL;
CREATE INDEX ",strsplit(into, "\\.")[[1]][2],"_gist on ",into," using GIST(geom);
ALTER TABLE ",into," CLUSTER ON ",strsplit(into, "\\.")[[1]][2],"_gist;
", sep = "")
)

if(!is.na(subset_target_table))
  {
    sql <- gsub(") tgt", paste("where ", subset_target_table, "\n) tgt", sep = ""), sql)
  }
if(eval)
  {
    dbSendQuery(conn, sql)
  } else {
    return(sql)
  }

}
