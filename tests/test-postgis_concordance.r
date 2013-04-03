
require(swishdbtools)
ch <- connect2postgres2("django")
pwd <- getPassword()
sql <- postgis_concordance(conn = ch, source_table = "abs_sla.nswsla01",
                           target_table = "abs_sla.nswsla98",
                           into = "public.test",
                           tolerance = 0.01,
                           subset_target_table = "substr(cast(sla_code as text), 1, 3) = '105'",
                           eval = T
                           )
#cat(sql)
shp <- readOGR2(hostip="localhost", user="ivan_hanigan", db="django", layer="test", p = pwd)
head(shp@data)
choropleth(region.map=shp, stat="prop_olap_src_of_tgt")
