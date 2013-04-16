
################################################################
# name:gGeoCode2
#source("../R/gGeoCode2.r")
require(testthat)
require(devtools)
load_all()
  
address <- "1 Lineaus way acton canberra"
address2 <- c("1 Lineaus way acton canberra", "15 follett street scullin")
address3 <- as.data.frame(address2)
xy <- gGeoCode2(address)
xy <- gGeoCode2(address2)
xy <- gGeoCode2(address3)
xy
str(xy)
 
 
address <- "1 Lineaus way acton canberra"
locn <-   gGeoCode2(address)
str(locn)
test_that("address is returned",
{
  expect_that(nrow(
                   gGeoCode2(address)
                   ) == 1, is_true())
}
)
