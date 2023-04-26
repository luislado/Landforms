landforms <- function (ras, outfile = NULL, doNew = TRUE, sn = 3, ln = 7, 
          n.classes = "six", win = "rectangle") {
  slp <- terra::terrain(ras, v="slope", unit = "degrees", 
                         neighbors = sn * sn - 1)

  tp <- raster::terrain(ras, "TPI", 
                        neighbors = sn * sn - 1)
  
  saveFile <- if (!is.null(outfile)) {
    dir.create(dirname(outfile), showWarnings = FALSE)
    outfile
  }
  else paste0(tempfile(), ".tif")
  if (n.classes == "six") 
    saveFile <- gsub("\\.tif", "_six.tif", saveFile)
  if (n.classes == "ten") 
    saveFile <- gsub("\\.tif", "_ten.tif", saveFile)
  if (!doNew) {
    if (!file.exists(saveFile)) 
      doNew <- TRUE
  }
  if (doNew) {
    if (n.classes == "six") {
      topo_six_class <- function(tp, slp) {
        ifelse(tp <= -1, 1, ifelse(tp > -1 & tp <= -0.5, 
                                   2, ifelse(tp > -0.5 & tp < 0.5 & slp <= 5, 
                                             3, ifelse(tp > -0.5 & tp < 0.5 & slp > 5, 
                                                       4, ifelse(tp > 0.5 & tp <= 1, 5, ifelse(tp > 
                                                                                                 1, 6, NA))))))
      }
      s <- raster::stack(raster(tp), raster(slp))
      ras <- raster::overlay(s, fun = topo_six_class, forcefun = TRUE)
      lscCol <- tibble::tibble(id = 1:6, colour = grDevices::terrain.colors(6), 
                               attribute = c("valley", "lower slope", "flat slope", 
                                             "middle slope", "upper slope", "ridge"))
    }
    else if (n.classes == "ten") {
      topo_ten_class <- function(sn, ln, slp) {
        ifelse(sn <= -1 & ln <= -1, 1, ifelse(sn <= -1 & 
                                                ln > -1 & ln < 1, 2, ifelse(sn <= -1 & ln >= 
                                                                              1, 3, ifelse(sn > -1 & sn < 1 & ln <= -1, 4, 
                                                                                           ifelse(sn > -1 & sn < 1 & ln > -1 & ln < 1 & 
                                                                                                    slp <= 5, 5, ifelse(sn > -1 & sn < 1 & ln > 
                                                                                                                          -1 & ln < 1 & slp > 5, 6, ifelse(sn > -1 & 
                                                                                                                                                             sn < 1 & ln >= 1, 7, ifelse(sn >= 1 & ln <= 
                                                                                                                                                                                           -1, 8, ifelse(sn >= 1 & ln > -1 & ln < 1, 
                                                                                                                                                                                                         9, ifelse(sn >= 1 & ln >= 1, 10, NA))))))))))
      }
      sn <- spatialEco::tpi(ras, scale = sn, win = win, 
                            normalize = TRUE)
      ln <- spatialEco::tpi(ras, scale = ln, win = win, 
                            normalize = TRUE)
      s <- raster::stack(raster(sn), raster(ln),raster(slp))
      ras <- raster::overlay(s, fun = topo_ten_class, forcefun = TRUE)
      lscCol <- tibble::tibble(id = 1:10, colour = grDevices::terrain.colors(10), 
                               attribute = c("canyon", "midslope drainage", 
                                             "upland drainage", "u-shaped valley", "plains", 
                                             "open slopes", "upper slopes", "local ridges", 
                                             "midslopes ridges", "mountain tops"))
    }
    raster::writeRaster(ras,saveFile,format="GTiff",overwrite=TRUE)
  }
  raster::writeRaster(ras,saveFile,format="GTiff",overwrite=TRUE)
  }

