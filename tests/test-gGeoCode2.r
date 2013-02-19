
################################################################
# name:gGeoCode2
source("../R/gGeoCode2.r")
address <- "1 Lineaus way acton canberra"
test_that("address is returned",
{
  expect_that(nrow(gGeoCode2(address)) == 1, is_true())
}
)
