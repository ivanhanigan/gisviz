
require(swishdbtools)
ch <- connect2postgres2("django")
pwd <- getPassword()

dbSendQuery(ch, "drop table public.test")
yy <- "98"
sql <- postgis_concordance_multi(
                                 conn = ch
                                 ,
                                 source_zone_layers <- c('abs_sla.nswsla99','abs_sla.nswsla00', 'abs_sla.nswsla01', 'abs_sla.nswsla02', 'abs_sla.nswsla03', 'abs_sla.nswsla04', 'abs_sla.nswsla05', 'abs_sla.nswsla06', 'abs_sla.nswsla07')
                                 ,
                                 source_zones_code = "sla_code"
                                 ,
                                 target_table = "abs_sla.nswsla98"
                                 ,
                                 target_zones_code = "sla_code"
                                 ,
                                 into = "public.test98"
                                 ,
                                 tolerance = 0.01
                                 ,
                                 subset_target_table = "substr(cast(sla_code as text), 1, 3) = '105'"
                                 ,
                                 eval = T
                                 )
cat(sql)
sql_subset(ch , "public.test98", subset = "cast(target_zone_code as text) like '%0750'", eval = T)


dbSendQuery(ch, "drop table public.test99")
for(yy in zone_layers[-c(1:4)])
  {
#    yy <- "99"
    sql <- postgis_concordance_multi(conn = ch, source_table = sprintf("abs_sla.nswsla%s", yy),  source_zones_code = "sla_code",  target_table = "abs_sla.nswsla98", target_zones_code = "sla_code", into = paste("public.test", yy, sep = ""), tolerance = 0.01, subset_target_table = "substr(cast(sla_code as text), 1, 3) = '105'", eval = T)
    #cat(sql)
  }

sql_subset(ch , "public.test01", subset = "cast(target_zone_code as text) like '%0750'", eval = T)
rm(df)
for(yy in zone_layers[2:4])
  {
#   yy <- zone_layers[4]
    #cat(
    df1 <- sql_join(ch, x = "test98", y = paste("test", yy, sep = ""),
                   select.x = "target_zone_code",
                   select.y = c("target_zone_code", "source_zone_code", "prop_olap_src_of_tgt"),
                   by = "target_zone_code",
                   eval = T
                   )
#    )
    names(df1) <- c("target_zone_code", paste("code_",yy,sep=""), paste("prop_olap_",yy,sep=""))
    if(yy == zone_layers[2])
      {
        df <- df1
      } else {
        df <- merge(df, df1, by = "target_zone_code")
      }
  }
subset(df, code_01!= target_zone_code)
subset(df1, target_zone_code == 105500750)
# the problem is that the  matchs on target are repeated for multiple
# source segments.  suggest refining postgis intersection code to
# return multiple layers
nrow(df)
shp <- readOGR2(hostip="localhost", user="ivan_hanigan", db="django", layer="test", p = pwd)
head(shp@data)
choropleth(region.map=shp, stat="prop_olap_src_of_tgt")
