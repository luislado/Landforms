# Script to map terrain derivatives including landform classes from Digital Elevation Models
# Created by Luis Rodríguez Lado, PhD

# Load libraries
  library(terra)
  library(raster)

# Set Working Directory to local folder. Update the path if needed.
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
  # Load landforms function. Modified from the function envRaster::land_class. Description in ?land_class.
  source("landforms.R")

  # Load DEM 
  dem <- rast("Topography/DEM_250_25829.tif")
  six <- landforms(dem,"landforms.tif",doNew=T,sn=3,ln=7,n.classes="six",win="rectangle")
  plot(six)
  ten <- landforms(dem,"landforms.tif",doNew=T,sn=3,ln=7,n.classes="ten",win="rectangle")
  plot(ten)

  # Obtain DEM derived maps
  derived_vars <- terra::terrain(dem, c("slope", "roughness", "aspect", "flowdir", "aspect","TPI","TRI","TRIriley", "TRIrmsd"), unit = "degrees")
  slope <- derived_vars[["slope"]]; #plot(slope)
  roughness <- derived_vars[["roughness"]];  #plot(roughness)
  flowdir <- derived_vars[["flowdir"]];  #plot(flowdir)
  TPI <- derived_vars[["TPI"]];  #plot(TPI)
  TRI <- derived_vars[["TRI"]];  #plot(TRI)
  TRIriley <- derived_vars[["TRIriley"]];  #plot(TRIriley)
  TRIrmsd <- derived_vars[["TRIrmsd"]]; #plot(TRIrmsd)
  aspect <- derived_vars[["aspect"]];  #plot(aspect)
  northness <- cos(derived_vars[["aspect"]] * pi / 180);  #plot(northness)
  eastness <- sin(derived_vars[["aspect"]] * pi / 180);  #plot(eastness)
  
