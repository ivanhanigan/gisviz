
################################################################
  # name:gGeoCode2
#  source("../R/gGeoCode2.r")
  require(devtools)
  load_all()
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
